$items = @(
    # Files
    [PSCustomObject]@{ Path = "$env:SystemDrive\Users\Default\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\OneDrive.lnk"; Type = 'File'; Log = '' },
    [PSCustomObject]@{ Path = "$env:SystemRoot\System32\OneDriveSetup.exe"; Type = 'File'; Log = '' },
    [PSCustomObject]@{ Path = "$env:SystemRoot\SysWOW64\OneDriveSetup.exe"; Type = 'File'; Log = 'OneDrive' },
    
    # Registry
    [PSCustomObject]@{ Path = 'HKLM:\Software\Microsoft\WindowsUpdate\Orchestrator\UScheduler_Oobe\OutlookUpdate'; Type = 'Registry'; Log = 'Outlook' },
    [PSCustomObject]@{ Path = 'HKLM:\Software\Microsoft\WindowsUpdate\Orchestrator\UScheduler_Oobe\DevHomeUpdate'; Type = 'Registry'; Log = 'Dev Home' }
    
    # IFEO
    [PSCustomObject]@{ Path = 'OneDriveSetup.exe'; Type = 'IFEO'; Log = 'OneDrive' },
    [PSCustomObject]@{ Path = 'CompatTelRunner.exe'; Type = 'IFEO'; Log = 'Microsoft Compatibility Telemetry' },
    # [PSCustomObject]@{ Path = 'DeviceCensus.exe'; Type = 'IFEO'; Log = 'Device Census' },
    [PSCustomObject]@{ Path = 'GameBar.exe'; Type = 'IFEO'; Log = '' },
    [PSCustomObject]@{ Path = 'GameBarFtServer.exe'; Type = 'IFEO'; Log = '' },
    [PSCustomObject]@{ Path = 'GameBarPresenceWriter.exe'; Type = 'IFEO'; Log = 'Xbox Game Bar' },
    [PSCustomObject]@{ Path = 'MusNotification.exe'; Type = 'IFEO'; Log = '' },
    [PSCustomObject]@{ Path = 'MusNotificationUx.exe'; Type = 'IFEO'; Log = 'Updates are available popup' },
    [PSCustomObject]@{ Path = 'software_reporter_tool.exe'; Type = 'IFEO'; Log = 'Software Reporter Tool' },
    [PSCustomObject]@{ Path = 'GoogleCrashHandler.exe'; Type = 'IFEO'; Log = '' },
    [PSCustomObject]@{ Path = 'GoogleCrashHandler64.exe'; Type = 'IFEO'; Log = 'Google Crash Handler' },
    [PSCustomObject]@{ Path = 'jusched.exe'; Type = 'IFEO'; Log = 'Java Update Scheduler' },
    [PSCustomObject]@{ Path = 'pingsender.exe'; Type = 'IFEO'; Log = 'Ping Sender' },
    [PSCustomObject]@{ Path = 'default-browser-agent.exe'; Type = 'IFEO'; Log = 'Default Browser Agent' },
    [PSCustomObject]@{ Path = 'wsqmcons.exe'; Type = 'IFEO'; Log = 'Windows SQM Consolidator' },
    [PSCustomObject]@{ Path = 'DiagTrackRunner.exe'; Type = 'IFEO'; Log = 'Diagnostics Tracking Service' },
	# [PSCustomObject]@{ Path = 'mobsync.exe'; Type = 'IFEO'; Log = 'Synchronisation Center' },
    
    # Services
    [PSCustomObject]@{ Path = 'XblAuthManager'; Type = 'Service'; Log = 'Xbox Live Auth Manager' },
    [PSCustomObject]@{ Path = 'XblGameSave'; Type = 'Service'; Log = 'Xbox Live Game Save' },
    [PSCustomObject]@{ Path = 'XboxNetApiSvc'; Type = 'Service'; Log = 'Xbox Live Networking Service' },
    [PSCustomObject]@{ Path = 'DiagTrack'; Type = 'Service'; Log = 'Diagnostics Tracking Service' },
    [PSCustomObject]@{ Path = 'dmwappushservice'; Type = 'Service'; Log = 'Device Management WAP Push message Routing Service' },
    [PSCustomObject]@{ Path = 'WerSvc'; Type = 'Service'; Log = 'Windows Error Reporting Service' },
    [PSCustomObject]@{ Path = 'PcaSvc'; Type = 'Service'; Log = 'Program Compatibility Assistant Service' },
    [PSCustomObject]@{ Path = 'SysMain'; Type = 'Service'; Log = 'SysMain (Superfetch)' },
    [PSCustomObject]@{ Path = 'WalletService'; Type = 'Service'; Log = 'Microsoft Wallet' },
    [PSCustomObject]@{ Path = 'RetailDemo'; Type = 'Service'; Log = 'Retail Demo Service' },
    [PSCustomObject]@{ Path = 'WSearch'; Type = 'Service'; Log = 'Windows Search' },
    [PSCustomObject]@{ Path = 'MapsBroker'; Type = 'Service'; Log = 'Downloaded Maps Manager' },
    [PSCustomObject]@{ Path = 'WpcMonSvc'; Type = 'Service'; Log = 'Parental Controls' },
    [PSCustomObject]@{ Path = 'wisvc'; Type = 'Service'; Log = 'Windows Insider Service' },
    
    # Tasks
    [PSCustomObject]@{ Path = '\Microsoft\Windows\Application Experience\Microsoft Compatibility Appraiser Exp'; Type = 'Task'; Log = 'Microsoft Compatibility Appraiser Exp' },
    [PSCustomObject]@{ Path = '\Microsoft\Windows\Application Experience\Microsoft Compatibility Appraiser'; Type = 'Task'; Log = 'Microsoft Compatibility Appraiser' },
    [PSCustomObject]@{ Path = '\Microsoft\Windows\Application Experience\ProgramDataUpdater'; Type = 'Task'; Log = 'ProgramDataUpdater' },
    [PSCustomObject]@{ Path = '\Microsoft\Windows\Customer Experience Improvement Program\Consolidator'; Type = 'Task'; Log = 'Windows Customer Experience Improvement Program' },
    [PSCustomObject]@{ Path = '\Microsoft\Windows\Customer Experience Improvement Program\UsbCeip'; Type = 'Task'; Log = 'USB CEIP' },
    [PSCustomObject]@{ Path = '\Microsoft\Windows\Autochk\Proxy'; Type = 'Task'; Log = 'Proxy' },
    [PSCustomObject]@{ Path = '\Microsoft\Windows\DiskDiagnostic\Microsoft-Windows-DiskDiagnosticDataCollector'; Type = 'Task'; Log = 'Microsoft-Windows-DiskDiagnosticDataCollector' },
    [PSCustomObject]@{ Path = '\Microsoft\Windows\Feedback\Siuf\DmClient'; Type = 'Task'; Log = 'DmClient' },
    [PSCustomObject]@{ Path = '\Microsoft\Windows\Feedback\Siuf\DmClientOnScenarioDownload'; Type = 'Task'; Log = 'DmClientOnScenarioDownload' },
    [PSCustomObject]@{ Path = '\Microsoft\Windows\Windows Error Reporting\QueueReporting'; Type = 'Task'; Log = 'QueueReporting' },
    [PSCustomObject]@{ Path = '\Microsoft\Windows\Application Experience\MareBackup'; Type = 'Task'; Log = 'MareBackup' },
    [PSCustomObject]@{ Path = '\Microsoft\Windows\Application Experience\StartupAppTask'; Type = 'Task'; Log = 'StartupAppTask' },
    [PSCustomObject]@{ Path = '\Microsoft\Windows\Application Experience\PcaPatchDbTask'; Type = 'Task'; Log = 'PcaPatchDbTask' },
    [PSCustomObject]@{ Path = '\Microsoft\Windows\Maps\MapsUpdateTask'; Type = 'Task'; Log = 'MapsUpdateTask' }
)

foreach ($item in $items)
{
    $log = if ($item.Log) { $item.Log } else { $item.Path }
    
    if ($item.Type -in 'File', 'Registry')
    {
        if (Test-Path -LiteralPath $item.Path)
        {
            try
            {
                Remove-Item -LiteralPath $item.Path -Recurse -Force -ErrorAction Stop
                # if ($item.Log)
                # {
                #     Write-Log "Removed $log" "SUCCESS"
                # }
            }
            catch
            {
                Write-Log "FAILED to remove $log. Error: $($_.Exception.Message)" "WARN"
            }
        }
    }
    elseif ($item.Type -eq "IFEO")
    {
        $path = "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\$($item.Path)"
        
        try
        {
            if (!(Test-Path $path))
            {
                New-Item -Path $path -Force -ErrorAction Stop | Out-Null
            }
            
            Set-ItemProperty -Path $path -Name "Debugger" -Value "rundll32.exe" -Force -ErrorAction Stop
            
            # if ($item.Log)
            # {
            #     Write-Log "Blocked exe $log" "SUCCESS"
            # }
        }
        catch
        {
            Write-Log "FAILED to block exe $log. Error: $($_.Exception.Message)" "WARN"
        }
    }
    elseif ($item.Type -eq 'Service')
    {
        try
        {
            if ($service = Get-Service -Name $item.Path -ErrorAction SilentlyContinue)
            {
                if ($service.Status -ne 'Stopped')
                {
                    Stop-Service -Name $item.Path -Force
                }
                
                if ($service.StartType -ne 'Disabled')
                {
                    Set-Service -Name $item.Path -StartupType Disabled -ErrorAction Stop
                }
                
                # if ($item.Log)
                # {
                #     Write-Log "Disabled service $log" "SUCCESS"
                # }
            }
        }
        catch
        {
            Write-Log "FAILED to disable service $log. Error: $($_.Exception.Message)" "WARN"
        }
    }
    elseif ($item.Type -eq 'Task')
    {
        try
        {
            if ($task = Get-ScheduledTask -TaskName ($item.Path | Split-Path -Leaf) -TaskPath ($item.Path | Split-Path) -ErrorAction SilentlyContinue)
            {
                $task | Disable-ScheduledTask -ErrorAction Stop | Out-Null
                
                # if ($item.Log)
                # {
                #     Write-Log "Disabled task $log" "SUCCESS"
                # }
            }
        }
        catch
        {
            Write-Log "FAILED to disable task $log. Error: $($_.Exception.Message)" "WARN"
        }
    }
}