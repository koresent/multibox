Set-RegistryConfiguration -Items @(
    [PSCustomObject]@{ Path = 'HKLM:\SYSTEM\CurrentControlSet\Control\TimeZoneInformation'; Name = 'RealTimeIsUniversal'; Type = 'DWord'; Value = 1 }
)