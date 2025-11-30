Set-RegistryConfiguration -Items @(
    [PSCustomObject]@{ Path = 'HKLM:\SOFTWARE\Policies\Microsoft\Edge'; Name = 'HideFirstRunExperience'; Type = 'DWord'; Value = 1 },
	[PSCustomObject]@{ Path = 'HKLM:\SOFTWARE\Policies\Microsoft\Edge\Recommended'; Name = 'BackgroundModeEnabled'; Type = 'DWord'; Value = 0 },
	[PSCustomObject]@{ Path = 'HKLM:\SOFTWARE\Policies\Microsoft\Edge\Recommended'; Name = 'StartupBoostEnabled'; Type = 'DWord'; Value = 0 }
)