Set-RegistryConfiguration -Items @(
    [PSCustomObject]@{ Path = 'HKLM:\SYSTEM\CurrentControlSet\Control'; Name = 'WaitToKillServiceTimeout'; Type = 'String'; Value = '5000' },
	[PSCustomObject]@{ Path = 'HKLM:\SYSTEM\CurrentControlSet\Control'; Name = 'HungAppTimeout'; Type = 'String'; Value = '1000' }
)