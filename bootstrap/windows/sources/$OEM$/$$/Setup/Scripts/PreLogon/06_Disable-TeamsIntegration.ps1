Set-RegistryConfiguration -Items @(
    [PSCustomObject]@{ Path = 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Communications'; Name = 'ConfigureChatAutoInstall'; Type = 'DWord'; Value = 0 }
)