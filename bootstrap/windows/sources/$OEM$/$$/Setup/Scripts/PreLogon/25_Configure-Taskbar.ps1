Set-RegistryConfiguration -Items @(
    [PSCustomObject]@{ Path = 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\Explorer'; Name = 'StartLayoutFile'; Type = 'String'; Value = 'C:\Windows\Setup\Resources\TaskbarLayoutModification.xml' },
	[PSCustomObject]@{ Path = 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\Explorer'; Name = 'LockedStartLayout'; Type = 'DWord'; Value = 1 }
)