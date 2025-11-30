Set-RegistryConfiguration -Items @(
    [PSCustomObject]@{ Path = 'HKLM:\SYSTEM\Setup\MoSetup'; Name = 'AllowUpgradesWithUnsupportedTPMOrCPU'; Type = 'DWord'; Value = 1 }
)