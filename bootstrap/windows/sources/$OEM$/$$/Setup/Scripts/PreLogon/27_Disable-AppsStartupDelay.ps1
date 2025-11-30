Set-RegistryConfiguration -Items @(
    [PSCustomObject]@{ Path = 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Serialize'; Name = 'StartupDelayInMSec'; Type = 'DWord'; Value = 0 },
	[PSCustomObject]@{ Path = 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Serialize'; Name = 'WaitForIdleState'; Type = 'DWord'; Value = 0 }
)