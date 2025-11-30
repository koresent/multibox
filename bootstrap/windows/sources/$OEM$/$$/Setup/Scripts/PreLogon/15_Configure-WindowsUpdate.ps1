Set-RegistryConfiguration -Items @(
    [PSCustomObject]@{ Path = 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU'; Name = 'AUOptions'; Type = 'DWord'; Value = 4 },
	[PSCustomObject]@{ Path = 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU'; Name = 'NoAutoRebootWithLoggedOnUsers'; Type = 'DWord'; Value = 1 },
	[PSCustomObject]@{ Path = 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU'; Name = 'NoAutoUpdate'; Type = 'DWord'; Value = 0 },
	[PSCustomObject]@{ Path = 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU'; Name = 'ScheduledInstallDay'; Type = 'DWord'; Value = 0 },
	[PSCustomObject]@{ Path = 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU'; Name = 'ScheduledInstallTime'; Type = 'DWord'; Value = 3 },
	[PSCustomObject]@{ Path = 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU'; Name = 'ScheduledInstallEveryWeek'; Type = 'DWord'; Value = 1 }
)