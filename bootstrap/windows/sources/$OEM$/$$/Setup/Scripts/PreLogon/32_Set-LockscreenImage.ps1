Set-RegistryConfiguration -Items @(
    [PSCustomObject]@{ Path = 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\PersonalizationCSP'; Name = 'LockScreenImagePath'; Type = 'String'; Value = 'C:\Windows\Setup\Resources\Lockscreen.png' }
)