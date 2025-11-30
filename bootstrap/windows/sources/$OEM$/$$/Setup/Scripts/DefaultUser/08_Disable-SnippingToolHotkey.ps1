Set-RegistryConfiguration -Items @(
    [PSCustomObject]@{ Path = 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced'; Name = 'DisabledHotkeys'; Type = 'String'; Value = 'S' }
)