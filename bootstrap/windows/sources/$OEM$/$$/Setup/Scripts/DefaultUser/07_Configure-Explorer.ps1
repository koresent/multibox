Set-RegistryConfiguration -Items @(
    # Show file extensions (e.g., .txt, .exe) in Explorer
    [PSCustomObject]@{ Path = 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced'; Name = 'HideFileExt'; Type = 'DWord'; Value = 0 },
    
    # Show hidden files and folders
    [PSCustomObject]@{ Path = 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced'; Name = 'Hidden'; Type = 'DWord'; Value = 1 },
    
    # Restore the Classic Context Menu by blocking the new Windows 11 menu
    [PSCustomObject]@{ Path = 'HKCU:\SOFTWARE\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}\InprocServer32'; Name = $null; Type = 'String'; Value = '' },
    
    # Enable "Compact Mode" in Explorer (less padding between items)
    [PSCustomObject]@{ Path = 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced'; Name = 'UseCompactMode'; Type = 'DWord'; Value = 1 },

    # Hide the "Task View" button from the Taskbar
    [PSCustomObject]@{ Path = 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced'; Name = 'ShowTaskViewButton'; Type = 'DWord'; Value = 0 },

    # Hide the Search box/icon on the Taskbar
    [PSCustomObject]@{ Path = 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Search'; Name = 'SearchboxTaskbarMode'; Type = 'DWord'; Value = 0; },

    # Hide search box in the system tray
    [PSCustomObject]@{ Path = 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Search'; Name = 'TraySearchBoxVisible'; Type = 'DWord'; Value = 0; },

    # Hide search box on additional monitors
    [PSCustomObject]@{ Path = 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Search'; Name = 'TraySearchBoxVisibleOnAnyMonitor'; Type = 'DWord'; Value = 0; },

    # Configure onboard search box behavior
    [PSCustomObject]@{ Path = 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Search'; Name = 'OnboardSearchboxOnTaskbar'; Type = 'DWord'; Value = 2; },

    # Store previous search mode state
    [PSCustomObject]@{ Path = 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Search'; Name = 'SearchboxTaskbarModePrevious'; Type = 'DWord'; Value = 2; },

    # Set the reason for disabling the search box
    [PSCustomObject]@{ Path = 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Search'; Name = 'SearchBoxDisabledReason'; Type = 'String'; Value = 'FromServer'; },

    # Disable the Snap Assist flyout
    [PSCustomObject]@{ Path = 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced'; Name = 'EnableSnapAssistFlyout'; Type = 'DWord'; Value = 0 },
    
    # Disable the Snap Bar
    [PSCustomObject]@{ Path = 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced'; Name = 'EnableSnapBar'; Type = 'DWord'; Value = 0 },

    # Define the CLSID for "Home" (MS Graph) folder
    [PSCustomObject]@{ Path = 'HKCU:\SOFTWARE\Classes\CLSID\{f874310e-b6b7-47dc-bc84-b9e6b38f5903}'; Name = $null; Type = 'String'; Value = 'CLSID_MSGraphHomeFolder' },
    
    # Unpin "Home" from the Navigation Pane
    [PSCustomObject]@{ Path = 'HKCU:\SOFTWARE\Classes\CLSID\{f874310e-b6b7-47dc-bc84-b9e6b38f5903}'; Name = 'System.IsPinnedToNameSpaceTree'; Type = 'DWord'; Value = 0 },
    
    # Define the CLSID for the "Gallery" folder
    [PSCustomObject]@{ Path = 'HKCU:\SOFTWARE\Classes\CLSID\{e88865ea-0e1c-4e20-9aa6-edcd0212c87c}'; Name = $null; Type = 'String'; Value = 'Gallery' },
    
    # Unpin "Gallery" from the Navigation Pane
    [PSCustomObject]@{ Path = 'HKCU:\SOFTWARE\Classes\CLSID\{e88865ea-0e1c-4e20-9aa6-edcd0212c87c}'; Name = 'System.IsPinnedToNameSpaceTree'; Type = 'DWord'; Value = 0 },

    # Hide icons for Classic Start Menu namespace
    [PSCustomObject]@{ Path = 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\ClassicStartMenu'; Name = '{5399e694-6ce5-4d6c-8fce-1d8870fdcba0}'; Type = 'DWord'; Value = 1 },
    [PSCustomObject]@{ Path = 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\ClassicStartMenu'; Name = '{b4bfcc3a-db2c-424c-b029-7fe99a87c641}'; Type = 'DWord'; Value = 1 },
    [PSCustomObject]@{ Path = 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\ClassicStartMenu'; Name = '{a8cdff1c-4878-43be-b5fd-f8091c1c60d0}'; Type = 'DWord'; Value = 1 },
    [PSCustomObject]@{ Path = 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\ClassicStartMenu'; Name = '{374de290-123f-4565-9164-39c4925e467b}'; Type = 'DWord'; Value = 1 },
    [PSCustomObject]@{ Path = 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\ClassicStartMenu'; Name = '{e88865ea-0e1c-4e20-9aa6-edcd0212c87c}'; Type = 'DWord'; Value = 1 }, # Gallery
    [PSCustomObject]@{ Path = 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\ClassicStartMenu'; Name = '{f874310e-b6b7-47dc-bc84-b9e6b38f5903}'; Type = 'DWord'; Value = 1 }, # Home
    [PSCustomObject]@{ Path = 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\ClassicStartMenu'; Name = '{1cf1260c-4dd0-4ebb-811f-33c572699fde}'; Type = 'DWord'; Value = 1 },
    [PSCustomObject]@{ Path = 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\ClassicStartMenu'; Name = '{f02c1a0d-be21-4350-88b0-7367fc96ef3c}'; Type = 'DWord'; Value = 1 },
    [PSCustomObject]@{ Path = 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\ClassicStartMenu'; Name = '{3add1653-eb32-4cb0-bbd7-dfa0abb5acca}'; Type = 'DWord'; Value = 1 },
    [PSCustomObject]@{ Path = 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\ClassicStartMenu'; Name = '{645ff040-5081-101b-9f08-00aa002f954e}'; Type = 'DWord'; Value = 1 }, # Recycle Bin (usually)
    [PSCustomObject]@{ Path = 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\ClassicStartMenu'; Name = '{20d04fe0-3aea-1069-a2d8-08002b30309d}'; Type = 'DWord'; Value = 1 },
    [PSCustomObject]@{ Path = 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\ClassicStartMenu'; Name = '{59031a47-3f72-44a7-89c5-5595fe6b30ee}'; Type = 'DWord'; Value = 1 },
    [PSCustomObject]@{ Path = 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\ClassicStartMenu'; Name = '{a0953c92-50dc-43bf-be83-3742fed03c9c}'; Type = 'DWord'; Value = 1 },

    # Hide icons for New Start Panel namespace
    [PSCustomObject]@{ Path = 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel'; Name = '{5399e694-6ce5-4d6c-8fce-1d8870fdcba0}'; Type = 'DWord'; Value = 1 },
    [PSCustomObject]@{ Path = 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel'; Name = '{b4bfcc3a-db2c-424c-b029-7fe99a87c641}'; Type = 'DWord'; Value = 1 },
    [PSCustomObject]@{ Path = 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel'; Name = '{a8cdff1c-4878-43be-b5fd-f8091c1c60d0}'; Type = 'DWord'; Value = 1 },
    [PSCustomObject]@{ Path = 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel'; Name = '{374de290-123f-4565-9164-39c4925e467b}'; Type = 'DWord'; Value = 1 },
    [PSCustomObject]@{ Path = 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel'; Name = '{e88865ea-0e1c-4e20-9aa6-edcd0212c87c}'; Type = 'DWord'; Value = 1 },
    [PSCustomObject]@{ Path = 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel'; Name = '{f874310e-b6b7-47dc-bc84-b9e6b38f5903}'; Type = 'DWord'; Value = 1 },
    [PSCustomObject]@{ Path = 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel'; Name = '{1cf1260c-4dd0-4ebb-811f-33c572699fde}'; Type = 'DWord'; Value = 1 },
    [PSCustomObject]@{ Path = 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel'; Name = '{f02c1a0d-be21-4350-88b0-7367fc96ef3c}'; Type = 'DWord'; Value = 1 },
    [PSCustomObject]@{ Path = 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel'; Name = '{3add1653-eb32-4cb0-bbd7-dfa0abb5acca}'; Type = 'DWord'; Value = 1 },
    [PSCustomObject]@{ Path = 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel'; Name = '{645ff040-5081-101b-9f08-00aa002f954e}'; Type = 'DWord'; Value = 1 },
    [PSCustomObject]@{ Path = 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel'; Name = '{20d04fe0-3aea-1069-a2d8-08002b30309d}'; Type = 'DWord'; Value = 1 },
    [PSCustomObject]@{ Path = 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel'; Name = '{59031a47-3f72-44a7-89c5-5595fe6b30ee}'; Type = 'DWord'; Value = 1 },
    [PSCustomObject]@{ Path = 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel'; Name = '{a0953c92-50dc-43bf-be83-3742fed03c9c}'; Type = 'DWord'; Value = 1 },

    # Clear visible places/folders in the Start Menu
    [PSCustomObject]@{ Path = 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Start'; Name = 'VisiblePlaces'; Type = 'Binary'; Value = $( [convert]::FromBase64String('') ) },
    
    # Set default Explorer opening location
    [PSCustomObject]@{ Path = 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced'; Name = 'LaunchTo'; Type = 'DWord'; Value = 3 },

    # Reduce menu show delay to 200ms
    [PSCustomObject]@{ Path = 'HKCU:\Control Panel\Desktop'; Name = 'MenuShowDelay'; Type = 'DWord'; Value = 200 },
    
    # Set Wallpaper JPEG import quality to 100%
    [PSCustomObject]@{ Path = 'HKCU:\Control Panel\Desktop'; Name = 'JPEGImportQuality'; Type = 'DWord'; Value = 100 },
    
    # Disable automatic folder type discovery
    [PSCustomObject]@{ Path = 'HKCU:\SOFTWARE\Classes\Local Settings\SOFTWARE\Microsoft\Windows\Shell\Bags\AllFolders\Shell'; Name = 'FolderType'; Type = 'String'; Value = 'NotSpecified' },
    [PSCustomObject]@{ Path = 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer'; Name = 'FolderType'; Type = 'String'; Value = 'NotSpecified' },

    # Remove the "- Shortcut" suffix text when creating new shortcuts
    [PSCustomObject]@{ Path = 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer'; Name = 'link'; Type = 'Binary'; Value = [byte[]]@(0x00, 0x00, 0x00, 0x00) }
)