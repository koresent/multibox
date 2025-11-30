Set-RegistryConfiguration -Items @(
    [PSCustomObject]@{ Path = 'HKLM:\SYSTEM\CurrentControlSet\Control\FileSystem'; Name = 'LongPathsEnabled'; Type = 'DWord'; Value = 1 }
)