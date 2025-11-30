Set-RegistryConfiguration -Items @(
    [PSCustomObject]@{ Path = 'HKCU:\Control Panel\Accessibility\StickyKeys'; Name = 'Flags'; Type = 'String'; Value = '506' },
	[PSCustomObject]@{ Path = 'HKCU:\Control Panel\Accessibility\Keyboard Response'; Name = 'Flags'; Type = 'String'; Value = '122' },
	[PSCustomObject]@{ Path = 'HKCU:\Control Panel\Accessibility\ToggleKeys'; Name = 'Flags'; Type = 'String'; Value = '58' }
)