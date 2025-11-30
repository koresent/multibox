Set-RegistryConfiguration -Items @(
    [PSCustomObject]@{ Path = 'HKLM:\SYSTEM\CurrentControlSet\Control\Terminal Server'; Name = 'fDenyTSConnections'; Type = 'DWord'; Value = 0 },
	[PSCustomObject]@{ Path = 'HKLM:\SOFTWARE\Policies\Microsoft\Windows NT\Terminal Services\Client'; Name = 'fClientDisableUDP'; Type = 'DWord'; Value = 0 },
	[PSCustomObject]@{ Path = 'HKLM:\SYSTEM\CurrentControlSet\Control\Terminal Server\WinStations\RDP-Tcp'; Name = 'UserAuthentication'; Type = 'DWord'; Value = 1 }
)

Get-NetFirewallRule -DisplayGroup "Remote Desktop" | Set-NetFirewallRule -Enabled True