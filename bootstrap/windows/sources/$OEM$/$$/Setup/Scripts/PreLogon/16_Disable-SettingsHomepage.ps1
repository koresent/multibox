Set-RegistryConfiguration -Items @(
    [PSCustomObject]@{ Path = 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer'; Name = 'SettingsPageVisibility'; Type = 'String'; Value = 'hide:home' }
)