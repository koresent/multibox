Set-RegistryConfiguration -Items @(
    # Theme & effects
    [PSCustomObject]@{ Path = 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize'; Name = 'SystemUsesLightTheme'; Type = 'DWord'; Value = 0 },
	[PSCustomObject]@{ Path = 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize'; Name = 'AppsUseLightTheme'; Type = 'DWord'; Value = 0 },
	[PSCustomObject]@{ Path = 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize'; Name = 'ColorPrevalence'; Type = 'DWord'; Value = 0 },
	[PSCustomObject]@{ Path = 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize'; Name = 'EnableTransparency'; Type = 'DWord'; Value = 1 },
    
	# StartColorMenu
    [PSCustomObject]@{ Path = 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Accent'; Name = 'StartColorMenu'; Type = 'DWord'; Value = 0xff00665f },
    
    # AccentColorMenu
    [PSCustomObject]@{ Path = 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Accent'; Name = 'AccentColorMenu'; Type = 'DWord'; Value = 0xff007d75 },
    
    # DWM AccentColor
    [PSCustomObject]@{ Path = 'HKCU:\SOFTWARE\Microsoft\Windows\DWM'; Name = 'AccentColor'; Type = 'DWord'; Value = 0xff007d75 },
    
    # AccentPalette (Binary array)
    [PSCustomObject]@{ 
        Path  = 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Accent'; 
        Name  = 'AccentPalette'; 
        Type  = 'Binary'; 
        Value = ([byte[]](0xc8,0xd6,0x00,0xff,0xa7,0xb2,0x00,0xff,0x8f,0x99,0x00,0xff,0x77,0x7f,0x00,0xff,0x5f,0x66,0x00,0xff,0x47,0x4c,0x00,0xff,0x26,0x28,0x00,0xff,0x88,0x17,0x98,0x00)) 
    },
	
	# Apply appearance
	[PSCustomObject]@{ Path = 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects'; Name = 'VisualFXSetting'; Type = 'DWord'; Value = 3 },

    # Wallpaper
	[PSCustomObject]@{ Path = 'HKCU:\Control Panel\Desktop'; Name = 'WallPaper'; Type = 'String'; Value = 'C:\Windows\Setup\Resources\Wallpaper.png' },
	[PSCustomObject]@{ Path = 'HKCU:\Control Panel\Desktop'; Name = 'WallpaperStyle'; Type = 'String'; Value = '0' }
)