<#
.SYNOPSIS
    Orchestrator for executing Windows setup modules by stage.
.DESCRIPTION
    Searches for scripts in the subdirectory corresponding to the passed Stage parameter,
    and executes them in alphabetical order with logging.
    Loads global functions from $PSScriptRoot\Functions before execution.
.PARAMETER Stage
    Name of the stage to run. Allowed values: PreInstall, PreLogon, PostLogon, DefaultUser.
#>
[CmdletBinding()]
param (
    [Parameter(Mandatory = $true, Position = 0)]
    [ValidateSet("PreInstall", "PreLogon", "PostLogon", "DefaultUser")]
    [string]$Stage
)

# Maximize window
try {
    $WindowCode = @"
    using System;
    using System.Runtime.InteropServices;

    public class ConsoleWindow {
        [DllImport("kernel32.dll")]
        public static extern IntPtr GetConsoleWindow();

        [DllImport("user32.dll")]
        public static extern int GetWindowLong(IntPtr hWnd, int nIndex);

        [DllImport("user32.dll")]
        public static extern int SetWindowLong(IntPtr hWnd, int nIndex, int dwNewLong);

        [DllImport("user32.dll")]
        public static extern bool SetWindowPos(IntPtr hWnd, IntPtr hWndInsertAfter, int X, int Y, int cx, int cy, uint uFlags);

        [DllImport("user32.dll")]
        public static extern int GetSystemMetrics(int nIndex);

        // Const
        public const int GWL_STYLE = -16;
        public const int WS_CAPTION = 0x00C00000;      
        public const int WS_THICKFRAME = 0x00040000;   
        public const int WS_SYSMENU = 0x00080000;      
        
        public const int SM_CXSCREEN = 0; // Screen Width
        public const int SM_CYSCREEN = 1; // Screen Height
        
        public const uint SWP_FRAMECHANGED = 0x0020;
        public const uint SWP_SHOWWINDOW = 0x0040;

        public static void SetFullscreen() {
            IntPtr hwnd = GetConsoleWindow();
            if (hwnd != IntPtr.Zero) {
                int screenWidth = GetSystemMetrics(SM_CXSCREEN);
                int screenHeight = GetSystemMetrics(SM_CYSCREEN);
                int style = GetWindowLong(hwnd, GWL_STYLE);
                style &= ~(WS_CAPTION | WS_THICKFRAME | WS_SYSMENU);
                SetWindowLong(hwnd, GWL_STYLE, style);
                SetWindowPos(hwnd, IntPtr.Zero, 0, 0, screenWidth + 30, screenHeight, SWP_FRAMECHANGED | SWP_SHOWWINDOW);
            }
        }
    }
"@
    Add-Type -TypeDefinition $WindowCode -Language CSharp
    
    if ($Stage -eq "PreLogon" -or $Stage -eq "PreInstall") {
        try {
            $rawUi = $Host.UI.RawUI
            $buffer = $rawUi.BufferSize
            $buffer.Width = 300 
            $buffer.Height = 3000
            $rawUi.BufferSize = $buffer
        } catch {}

        [ConsoleWindow]::SetFullscreen()
    }
} catch {}

# Config
if ($Stage -eq "DefaultUser") {
    $LogDir = $env:TEMP
}
else {
    $LogDir = "$env:SystemRoot\Panther"
    if (!(Test-Path $LogDir)) {
        try { New-Item -Path $LogDir -ItemType Directory -Force | Out-Null }
        catch { $LogDir = $env:TEMP }
    }
}

$LogFile = Join-Path $LogDir "Setup-$Stage.log"
$StagePath = Join-Path $PSScriptRoot $Stage
$FunctionsPath = Join-Path $PSScriptRoot "Functions"

$ProgressPreference = 'SilentlyContinue'

# Log init
$LogHeader = @"
==========================================
Orchestrator Log Started: $(Get-Date -Format "yyyy-MM-dd HH:mm:ss")
Stage: $Stage
==========================================
"@
Set-Content -Path $LogFile -Value $LogHeader -Encoding UTF8

# Functions
function Write-Log {
    param (
        [Parameter(Mandatory = $true)]
        [string]$Message,
        [ValidateSet("INFO", "WARN", "ERROR", "SUCCESS", "DEBUG")]
        [string]$Level = "INFO",
        [switch]$ConsoleOutput = $false
    )
    $TimeStamp = Get-Date -Format "HH:mm:ss"
    $LogLine = "[$TimeStamp] [$Level] $Message"
    
    Add-Content -Path $LogFile -Value $LogLine -Encoding UTF8

    if ($Level -in "ERROR", "WARN" -or $ConsoleOutput) {
        Write-Host "" 
        $Color = switch ($Level) { "ERROR" { "Red" } "SUCCESS" { "Green" } "WARN" { "Yellow" } Default { "Gray" } }
        Write-Host $LogLine -ForegroundColor $Color
    }
}

function Write-ProgressLine {
    param(
        [int]$Index,
        [int]$Total,
        [string]$Name,
        [string]$Status = "RUNNING"
    )
    
    $ProgressStr = "[{0}/{1}]" -f $Index, $Total
    
    switch ($Status) {
        "RUNNING" { 
            $Icon = ".." 
            $Color = "Cyan"
            $NoNewline = $true
        }
        "DONE" { 
            $Icon = "OK" 
            $Color = "Green"
            $NoNewline = $false
        }
        "FAIL" { 
            $Icon = "ER" 
            $Color = "Red"
            $NoNewline = $false
        }
    }

    $Message = "`r[$Icon] $ProgressStr $Name" + (" " * 20)
    
    Write-Host $Message -ForegroundColor $Color -NoNewline:$NoNewline
}

# Execution
New-PSDrive -Name HKU -PSProvider Registry -Root HKEY_USERS | Out-Null
New-PSDrive -Name HKCR -PSProvider Registry -Root HKEY_CLASSES_ROOT | Out-Null

try {
    Write-Log "=== STARTING ORCHESTRATOR FOR STAGE: $Stage ==="
    
    if ($Stage -eq 'PreLogon') {
        $regLoad = reg.exe load "HKU\DefaultUser" "C:\Users\Default\NTUSER.DAT" 2>&1
        if ($LASTEXITCODE -eq 0) {
            $hiveMounted = $true
        } else {
            Write-Log "Failed to mount DefaultUser hive: $regLoad" "ERROR"
            throw
        }
    }
    
    # Load external functions
    if (Test-Path $FunctionsPath) {
        $FunctionFiles = Get-ChildItem -Path $FunctionsPath -Filter "*.ps1"
        foreach ($FuncFile in $FunctionFiles) {
            try {
                . $FuncFile.FullName
                Write-Log "Loaded function: $($FuncFile.Name)" -Level DEBUG
            } catch {
                Write-Log "Failed to load $($FuncFile.Name): $($_.Exception.Message)" "ERROR"
                throw "Critical error loading shared functions."
            }
        }
    }

    # Scripts execution
    if (!(Test-Path $StagePath)) { throw "Stage directory not found: $StagePath" }
    
    $Scripts = Get-ChildItem -Path $StagePath -Filter "*.ps1" | Sort-Object Name
    $TotalScripts = $Scripts.Count
    $Counter = 0

    if ($TotalScripts -eq 0) {
        Write-Log "No .ps1 scripts found." "WARN" -ConsoleOutput
    }

    foreach ($Script in $Scripts) {
        $Counter++
        
        $PrettyName = $Script.BaseName -replace '^\d+[_\-\.]', '' -creplace '([a-z])([A-Z])', '$1 $2' -replace '[-_]', ' '
        
        Write-ProgressLine -Index $Counter -Total $TotalScripts -Name $PrettyName -Status "RUNNING"
        
        Write-Log "--> START: $($Script.Name)"

        try {
            $sw = [System.Diagnostics.Stopwatch]::StartNew()
            
            . $Script.FullName
            
            $sw.Stop()
            Write-Log "<-- END: $($Script.Name) (Time: $($sw.Elapsed.ToString('mm\:ss\.fff')))" "SUCCESS"
            
            Write-ProgressLine -Index $Counter -Total $TotalScripts -Name $PrettyName -Status "DONE"
        }
        catch {
            Write-Log "FAILURE in $($Script.Name): $($_.Exception.Message)" "ERROR"
            Write-Log "Trace: $($_.ScriptStackTrace)" "ERROR"
            
            Write-ProgressLine -Index $Counter -Total $TotalScripts -Name $PrettyName -Status "FAIL"
        }
    }
}
catch {
    Write-Log "CRITICAL ORCHESTRATOR FAIL: $($_.Exception.Message)" "ERROR" -ConsoleOutput
    exit 1
}
finally {
    if ($HiveMounted) {
        [GC]::Collect()
        [GC]::WaitForPendingFinalizers()
        $retries = 0
        do {
            $regUnload = reg.exe unload "HKU\DefaultUser" 2>&1
            if ($LASTEXITCODE -ne 0) {
                Write-Log "Unload retry... ($regUnload)" "WARN"
                Start-Sleep -Seconds 2
                $retries++
            }
        } while ($LASTEXITCODE -ne 0 -and $retries -lt 5)
    }
    Write-Log "=== COMPLETED STAGE: $Stage ==="
}