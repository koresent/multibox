Set-RegistryConfiguration -Items @(
    [PSCustomObject]@{ Path = 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\DeviceGuard'; Name = 'EnableVirtualizationBasedSecurity'; Type = 'DWord'; Value = 1 },
	[PSCustomObject]@{ Path = 'HKLM:\SYSTEM\CurrentControlSet\Control\DeviceGuard\Scenarios\HypervisorEnforcedCodeIntegrity'; Name = 'Enabled'; Type = 'DWord'; Value = 0 },
	[PSCustomObject]@{ Path = 'HKLM:\SYSTEM\CurrentControlSet\Control\DeviceGuard\Scenarios\HypervisorEnforcedCodeIntegrity'; Name = 'EnabledBootId'; Type = 'DWord'; Value = 0 },
	[PSCustomObject]@{ Path = 'HKLM:\SYSTEM\CurrentControlSet\Control\DeviceGuard\Scenarios\HypervisorEnforcedCodeIntegrity'; Name = 'WasEnabledBy'; Type = 'DWord'; Value = 0 }
)