Set-RegistryConfiguration -Items @(
    [PSCustomObject]@{ Path = 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced\TaskbarDeveloperSettings'; Name = 'TaskbarEndTask'; Type = 'DWord'; Value = 1 }
)