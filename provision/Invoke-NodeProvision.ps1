#Requires -RunAsAdministrator

<#
.SYNOPSIS
  Lightweight Configuration Manager
#>
[CmdletBinding()]
param (
    [Parameter(Mandatory = $true, Position = 0)]
    [ValidateScript({
            $nodesPath = Join-Path $PSScriptRoot "nodes"
            $targetFile = Join-Path $nodesPath $_
        
            if (!(Test-Path $targetFile -PathType Leaf)) {
                throw "File '$_' not found in '$nodesPath'. Please specify the filename only (e.g., 'Test-Node.ps1')."
            }
        
            if ([System.IO.Path]::GetExtension($_) -ne ".ps1") {
                throw "Invalid file type. Only .ps1 files are allowed."
            }
        
            return $true
        })]
    [string]$ScriptName
)

$ProgressPreference = 'SilentlyContinue'

############
# Functions
############

function Get-OS {
    if ($PSVersionTable.PSVersion.Major -ge 6) {
        if ($IsWindows) { return 'Windows' }
        if ($IsLinux) { return 'Linux' }
        if ($IsMacOS) { return 'MacOS' }
    }
    else {
        return 'Windows'
    }
    return 'Unknown'
}

function Set-Package {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $true)]
        [string]$Name,
        [Parameter(Mandatory = $true)]
        [string]$Provider
    )
    
    $currentOS = Get-OS
    
    if ($currentOS -eq 'Windows') {
        if (!($script:PackageManagersSetup)) {

            # Install Winget
            if (!(Get-Command 'winget' -ErrorAction SilentlyContinue)) {
                Write-Host "📦 Installing Winget package manager..." -ForegroundColor Cyan
                $tmp = Join-Path $env:TEMP "wg-$(Get-Random)"
                New-Item $tmp -Type Directory -Force | Out-Null
                try {
                    $r = Invoke-RestMethod "https://api.github.com/repos/microsoft/winget-cli/releases/latest"
                    $bundleAsset = $r.assets | Where-Object { $_.name -match 'Microsoft.DesktopAppInstaller_.*\.msixbundle$' } | Select-Object -First 1
                    $depsAsset = $r.assets | Where-Object { $_.name -match 'DesktopAppInstaller_Dependencies.zip$' } | Select-Object -First 1
                    if (!$bundleAsset -or !$depsAsset) { 
                        throw "⚠️ Critical assets missing in latest release." 
                    }
                    $depsZipPath = Join-Path $tmp "deps.zip"
                    $bundlePath = Join-Path $tmp "winget.msixbundle"
                    Invoke-WebRequest $depsAsset.browser_download_url -OutFile $depsZipPath
                    Invoke-WebRequest $bundleAsset.browser_download_url -OutFile $bundlePath
                    $depsExtractPath = Join-Path $tmp "extracted"
                    Expand-Archive -Path $depsZipPath -DestinationPath $depsExtractPath -Force
                    $x64Path = Join-Path $depsExtractPath "x64"
                    if (Test-Path $x64Path) {
                        Get-ChildItem -Path $x64Path -Filter "*.appx" | ForEach-Object {
                            Add-AppxPackage $_.FullName -ErrorAction SilentlyContinue
                        }
                    }
                    else {
                        throw "⚠️ Architecture folder 'x64' not found in dependencies zip"
                    }
                    Add-AppxPackage $bundlePath -ErrorAction Stop
                }
                catch {
                    Write-Error "⚠️ Failed to install Winget: $_"
                    throw $_
                }
                finally {
                    Remove-Item $tmp -Recurse -Force -ErrorAction SilentlyContinue
                }
            }
            # Cache WinGet package list
            [string]$script:wingetCheck = winget list --source winget --accept-source-agreements

            # Install Chocolatey
            if (!(Get-Command 'choco' -ErrorAction SilentlyContinue)) {
                Write-Host "📦 Installing Chocolatey package manager..." -ForegroundColor Cyan
                Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1')) 
            }
            # Cache Chocolatey package list
            [string]$script:chocolateyCheck = choco list --limit-output

            # Install Scoop
            if (!(Get-Command 'scoop' -ErrorAction SilentlyContinue)) {
                Write-Host "📦 Installing Scoop package manager..." -ForegroundColor Cyan
                Invoke-Expression "& {$(Invoke-RestMethod get.scoop.sh)} -RunAsAdmin"
            }
            if (!(Get-Command 'git' -ErrorAction SilentlyContinue)) {
                winget install --id Git.Git -e --silent --source winget --accept-package-agreements --accept-source-agreements
            }
            if ([string](scoop bucket list) -notmatch 'https://github.com/ScoopInstaller/Extras') { scoop bucket add extras }
            # Cache Scoop package list
            $script:scoopCheck = ((scoop export) -join "`n" | ConvertFrom-Json).apps
            
            $script:PackageManagersSetup = $true
        }

        switch ($Provider) {
            winget { 
                if ($wingetCheck -notmatch $Name) {
                    winget install --id $Name -e --silent --source winget --accept-package-agreements --accept-source-agreements
                }
            }
            chocolatey {
                if ($chocolateyCheck -notmatch $Name) {
                    choco install $Name -y
                }
            }
            scoop {
                if (!($scoopCheck | Where-Object { $_.Name -eq ($Name -split "/")[-1] })) {
                    scoop install $Name
                }
            }
            Default { Write-Host "Provider $Provider not found" -ForegroundColor Red }
        }
    }
    elseif ($currentOS -eq 'Linux') {
        Write-Host "🐧 Linux placeholder" -ForegroundColor Yellow
    }
    elseif ($currentOS -eq 'MacOS') {
        Write-Host "🍎 MacOS placeholder" -ForegroundColor Yellow
    }
    else {
        Write-Host "👽 Unknown OS" -ForegroundColor Red
    }
    
    $env:Path = [System.Environment]::GetEnvironmentVariable("Path", "Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path", "User")
}

function Set-Config {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $true)]
        [string]$Source,

        [Parameter(Mandatory = $true)]
        [string]$Destination
    )

    # Cross-platform path fix
    $dstPath = $Destination -replace "^~", $HOME
    
    if (!(Test-Path -Path $Source)) {
        Write-Error "❌ Error: Source path not found: '$Source' in '$PWD'"
        return
    }
    
    $sourceItem = Get-Item -Path $Source

    if ($sourceItem.PSIsContainer) {
        $files = Get-ChildItem -Path $sourceItem.FullName -Recurse -File
        
        foreach ($file in $files) {
            $relPath = $file.FullName.Substring($sourceItem.FullName.Length)
            $relPath = $relPath.TrimStart([System.IO.Path]::DirectorySeparatorChar).TrimStart([System.IO.Path]::AltDirectorySeparatorChar)
            $targPath = Join-Path -Path $dstPath -ChildPath $relPath
            Set-Config -Source $file.FullName -Destination $targPath
        }
        return
    }

    $dstDir = Split-Path -Path $dstPath -Parent
    if (!(Test-Path -Path $dstDir)) {
        try {
            New-Item -ItemType Directory -Path $dstDir -Force | Out-Null
        }
        catch {
            Write-Host "⚠️ Failed to create directory $dstDir. $_" -ForegroundColor Red
            return
        }
    }

    if (!(Test-Path -Path $dstPath)) {
        Write-Host "📄 Copying config: $($sourceItem.Name) -> $dstPath" -ForegroundColor Green
        Copy-Item -Path $sourceItem.FullName -Destination $dstPath -Force
    }
    else {
        if ((Get-Item $dstPath).PSIsContainer) {
            Write-Error "⚠️ Destination '$dstPath' is a directory, but source is a file"
            return
        }

        $srcHash = Get-FileHash -Path $sourceItem.FullName -Algorithm SHA256
        $dstHash = Get-FileHash -Path $dstPath -Algorithm SHA256

        if ($srcHash.Hash -ne $dstHash.Hash) {
            Write-Host "📝 Updating config: $($sourceItem.Name)" -ForegroundColor Blue
            Copy-Item -Path $sourceItem.FullName -Destination $dstPath -Force
        }
    }
}

function Invoke-PackageSetup {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $true)]
        [array]$Packages
    )
    
    $os = Get-OS
    
    switch ($os) {
        'Windows' { $targetScript = "windows.ps1" }
        'Linux' { $targetScript = "linux.ps1" }
        'MacOS' { $targetScript = "macos.ps1" }
        Default { 
            Write-Error "Unknown Operating System: $os. Cannot determine target script."
            return 
        }
    }

    foreach ($package in $Packages) {
        $pkgPath = Join-Path (Join-Path $PSScriptRoot "components") $package

        if (!(Test-Path $pkgPath)) {
            Write-Host "⚠️ Package directory not found: $pkgPath" -ForegroundColor Yellow
            continue
        }

        $scriptToRun = Join-Path $pkgPath $targetScript

        if (Test-Path $scriptToRun -PathType Leaf) {
            Write-Host "🚀 Processing $package" -ForegroundColor Magenta
            
            Push-Location $pkgPath
            try {
                . $scriptToRun
            }
            catch {
                Write-Error "Failed executing package $package`: $_"
            }
            finally {
                Pop-Location
            }
        }
        else {
            Write-Host "⚠️ Package '$package' skipped. No '$targetScript' found." -ForegroundColor DarkGray
        }
    }
}

############
# Main
############
$scriptPath = Join-Path -Path (Join-Path -Path $PSScriptRoot -ChildPath "nodes") -ChildPath $ScriptName

if (!(Test-Path $scriptPath)) {
    throw "Node script not found at $scriptPath"
}

Write-Host "⚙️ Running Node: $ScriptName" -ForegroundColor Cyan

. $scriptPath

Write-Host "✔️ Node provisioning complete" -ForegroundColor Green