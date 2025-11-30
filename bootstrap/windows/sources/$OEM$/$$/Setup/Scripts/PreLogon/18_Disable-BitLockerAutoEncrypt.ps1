Set-RegistryConfiguration -Items @(
    [PSCustomObject]@{ Path = 'HKLM:\SYSTEM\CurrentControlSet\Control\BitLocker'; Name = 'PreventDeviceEncryption'; Type = 'DWord'; Value = 1 }
)