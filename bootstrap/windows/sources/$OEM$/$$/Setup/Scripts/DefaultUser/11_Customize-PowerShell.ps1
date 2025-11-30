Set-RegistryConfiguration -Items @(
    [PSCustomObject]@{ Path = 'HKCU:\Console\%SystemRoot%_System32_WindowsPowerShell_v1.0_powershell.exe'; Name = 'ColorTable00'; Type = 'DWord'; Value = 00000000 },
	[PSCustomObject]@{ Path = 'HKCU:\Console\%SystemRoot%_System32_WindowsPowerShell_v1.0_powershell.exe'; Name = 'ColorTable07'; Type = 'DWord'; Value = 00cccccc },
	[PSCustomObject]@{ Path = 'HKCU:\Console\%SystemRoot%_System32_WindowsPowerShell_v1.0_powershell.exe'; Name = 'ScreenColors'; Type = 'DWord'; Value = 00000007 },
	[PSCustomObject]@{ Path = 'HKCU:\Console\%SystemRoot%_System32_WindowsPowerShell_v1.0_powershell.exe'; Name = 'PopupColors'; Type = 'DWord'; Value = 000000f5 },
	[PSCustomObject]@{ Path = 'HKCU:\Console\%SystemRoot%_System32_WindowsPowerShell_v1.0_powershell.exe'; Name = 'FaceName'; Type = 'String'; Value = 'Consolas' },
	[PSCustomObject]@{ Path = 'HKCU:\Console\%SystemRoot%_System32_WindowsPowerShell_v1.0_powershell.exe'; Name = 'FontFamily'; Type = 'DWord'; Value = 00000036 },
	[PSCustomObject]@{ Path = 'HKCU:\Console\%SystemRoot%_System32_WindowsPowerShell_v1.0_powershell.exe'; Name = 'FontWeight'; Type = 'DWord'; Value = 00000190 },
	[PSCustomObject]@{ Path = 'HKCU:\Console\%SystemRoot%_System32_WindowsPowerShell_v1.0_powershell.exe'; Name = 'FontSize'; Type = 'DWord'; Value = 00100000 }
)