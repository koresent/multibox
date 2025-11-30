Set-RegistryConfiguration -Items @(
    [PSCustomObject]@{ Path = 'HKU:\DefaultUser\SOFTWARE\Microsoft\Windows\CurrentVersion\RunOnce'; Name = 'DefaultUser'; Type = 'String'; Value = "powershell.exe -WindowStyle Hidden -NoProfile -ExecutionPolicy Bypass -Command `"& 'C:\Windows\Setup\Scripts\Invoke-SetupStage.ps1' -Stage 'DefaultUser'`"" }
)