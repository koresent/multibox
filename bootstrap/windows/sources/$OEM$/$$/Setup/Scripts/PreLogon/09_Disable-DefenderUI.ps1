Set-RegistryConfiguration -Items @(
    # Disable notifications
    [PSCustomObject]@{ Path = 'HKLM:\SOFTWARE\Policies\Microsoft\Windows Defender Security Center\Notifications'; Name = 'DisableNotifications'; Type = 'DWord'; Value = 1 }
    
    # Disable SmartScreen (Explorer)
    [PSCustomObject]@{ Path = 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer'; Name = 'SmartScreenEnabled'; Type = 'String'; Value = 'Off' }
    
    # Disable Defender WTDS Components
    [PSCustomObject]@{ Path = 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\WTDS\Components'; Name = 'ServiceEnabled'; Type = 'DWord'; Value = 0 }
    [PSCustomObject]@{ Path = 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\WTDS\Components'; Name = 'NotifyMalicious'; Type = 'DWord'; Value = 0 }
    [PSCustomObject]@{ Path = 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\WTDS\Components'; Name = 'NotifyPasswordReuse'; Type = 'DWord'; Value = 0 }
    [PSCustomObject]@{ Path = 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\WTDS\Components'; Name = 'NotifyUnsafeApp'; Type = 'DWord'; Value = 0 }
    
    # Hide tray icon
    [PSCustomObject]@{ Path = 'HKLM:\SOFTWARE\Policies\Microsoft\Windows Defender Security Center\Systray'; Name = 'HideSystray'; Type = 'DWord'; Value = 1 }
    
    # Disable file reputation policy
    [PSCustomObject]@{ Path = 'HKLM:\SYSTEM\CurrentControlSet\Control\CI\Policy'; Name = 'VerifiedAndReputablePolicyState'; Type = 'DWord'; Value = 0 }
)