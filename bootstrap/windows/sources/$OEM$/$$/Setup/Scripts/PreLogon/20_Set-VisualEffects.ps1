Set-RegistryConfiguration -Items @(
    [PSCustomObject]@{ Path = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects\ControlAnimations"; Name = $null; Type = 'DWord'; Value = 1 },
    [PSCustomObject]@{ Path = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects\AnimateMinMax"; Name = $null; Type = 'DWord'; Value = 1 },
    [PSCustomObject]@{ Path = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects\TaskbarAnimations"; Name = $null; Type = 'DWord'; Value = 1 },
    [PSCustomObject]@{ Path = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects\DWMAeroPeekEnabled"; Name = $null; Type = 'DWord'; Value = 1 },
    [PSCustomObject]@{ Path = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects\MenuAnimation"; Name = $null; Type = 'DWord'; Value = 1 },
    [PSCustomObject]@{ Path = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects\TooltipAnimation"; Name = $null; Type = 'DWord'; Value = 1 },
    [PSCustomObject]@{ Path = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects\SelectionFade"; Name = $null; Type = 'DWord'; Value = 1 },
    [PSCustomObject]@{ Path = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects\DWMSaveThumbnailEnabled"; Name = $null; Type = 'DWord'; Value = 1 },
    [PSCustomObject]@{ Path = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects\ThumbnailsOrIcon"; Name = $null; Type = 'DWord'; Value = 1 },
    [PSCustomObject]@{ Path = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects\ListviewAlphaSelect"; Name = $null; Type = 'DWord'; Value = 1 },
    [PSCustomObject]@{ Path = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects\DragFullWindows"; Name = $null; Type = 'DWord'; Value = 1 },
    [PSCustomObject]@{ Path = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects\ComboBoxAnimation"; Name = $null; Type = 'DWord'; Value = 1 },
    [PSCustomObject]@{ Path = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects\FontSmoothing"; Name = $null; Type = 'DWord'; Value = 1 },
    [PSCustomObject]@{ Path = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects\ListBoxSmoothScrolling"; Name = $null; Type = 'DWord'; Value = 1 },
    
    # Disable shadows
    [PSCustomObject]@{ Path = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects\CursorShadow"; Name = $null; Type = 'DWord'; Value = 0 },
    [PSCustomObject]@{ Path = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects\ListviewShadow"; Name = $null; Type = 'DWord'; Value = 0 },
    [PSCustomObject]@{ Path = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects\DropShadow"; Name = $null; Type = 'DWord'; Value = 0 },
	
	# Force modern effects
	[PSCustomObject]@{ Path = "HKLM:\SOFTWARE\Microsoft\Windows\DWM"; Name = 'ForceEffectMode'; Type = 'DWord'; Value = 2 }
)