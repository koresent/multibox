Set-RegistryConfiguration -Items @(
	# Disables automatic installation of promoted apps (Candy Crush, TikTok, etc.) and "fun facts"
	[PSCustomObject]@{ Path = 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager'; Name = 'ContentDeliveryAllowed'; Type = 'DWord'; Value = 0 },
	[PSCustomObject]@{ Path = 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager'; Name = 'FeatureManagementEnabled'; Type = 'DWord'; Value = 0 },
	[PSCustomObject]@{ Path = 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager'; Name = 'OemPreInstalledAppsEnabled'; Type = 'DWord'; Value = 0 },
	[PSCustomObject]@{ Path = 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager'; Name = 'PreInstalledAppsEnabled'; Type = 'DWord'; Value = 0 },
	[PSCustomObject]@{ Path = 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager'; Name = 'PreInstalledAppsEverEnabled'; Type = 'DWord'; Value = 0 },
	[PSCustomObject]@{ Path = 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager'; Name = 'SoftLandingEnabled'; Type = 'DWord'; Value = 0 },
	[PSCustomObject]@{ Path = 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager'; Name = 'SystemPaneSuggestionsEnabled'; Type = 'DWord'; Value = 0 },
	[PSCustomObject]@{ Path = 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager'; Name = 'RotatingLockScreenOverlayEnabled'; Type = 'DWord'; Value = 0 },

    # Search & Bing
	[PSCustomObject]@{ Path = 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Search'; Name = 'BingSearchEnabled'; Type = 'DWord'; Value = 0 },
	[PSCustomObject]@{ Path = 'HKCU:\SOFTWARE\Policies\Microsoft\Windows\Explorer'; Name = 'DisableSearchBoxSuggestions'; Type = 'DWord'; Value = 1 },
	[PSCustomObject]@{ Path = 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Search'; Name = 'AllowSearchToUseLocation'; Type = 'QWord'; Value = 0 },

    # Cleans up the interface from ads and tracking of recently used apps
	[PSCustomObject]@{ Path = 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced'; Name = 'Start_TrackProgs'; Type = 'DWord'; Value = 0 },
	[PSCustomObject]@{ Path = 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced'; Name = 'ShowSyncProviderNotifications'; Type = 'DWord'; Value = 0 },
	[PSCustomObject]@{ Path = 'HKCU:\SOFTWARE\Policies\Microsoft\Windows\CloudContent'; Name = 'DisableSpotlightCollectionOnDesktop'; Type = 'DWord'; Value = 1 },

    # Prevents data collection for targeted ads and "tailored experiences"
	[PSCustomObject]@{ Path = 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\AdvertisingInfo'; Name = 'Enabled'; Type = 'DWord'; Value = 0 },
	[PSCustomObject]@{ Path = 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Privacy'; Name = 'TailoredExperiencesWithDiagnosticDataEnabled'; Type = 'DWord'; Value = 0 },
	[PSCustomObject]@{ Path = 'HKCU:\SOFTWARE\Microsoft\Siuf\Rules'; Name = 'NumberOfSIUFInPeriod'; Type = 'DWord'; Value = 0 },
	[PSCustomObject]@{ Path = 'HKCU:\SOFTWARE\Microsoft\Speech_OneCore\Settings\OnlineSpeechPrivacy'; Name = 'HasAccepted'; Type = 'DWord'; Value = 0 },
	[PSCustomObject]@{ Path = 'HKCU:\SOFTWARE\Microsoft\Personalization\Settings'; Name = 'AcceptedPrivacyPolicy'; Type = 'DWord'; Value = 0 },

    # Disables data collection from keyboard and inking
	[PSCustomObject]@{ Path = 'HKCU:\SOFTWARE\Microsoft\Input\TIPC'; Name = 'Enabled'; Type = 'DWord'; Value = 0 },
	[PSCustomObject]@{ Path = 'HKCU:\SOFTWARE\Microsoft\InputPersonalization'; Name = 'RestrictImplicitInkCollection'; Type = 'DWord'; Value = 1 },
	[PSCustomObject]@{ Path = 'HKCU:\SOFTWARE\Microsoft\InputPersonalization'; Name = 'RestrictImplicitTextCollection'; Type = 'DWord'; Value = 1 },
	[PSCustomObject]@{ Path = 'HKCU:\SOFTWARE\Microsoft\InputPersonalization\TrainedDataStore'; Name = 'HarvestContacts'; Type = 'DWord'; Value = 0 },
	
	# Security hardening to prevent apps from loading potentially unsafe web content
    [PSCustomObject]@{ Path = 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\AppHost'; Name = 'EnableWebContentEvaluation'; Type = 'DWord'; Value = 0 },
	[PSCustomObject]@{ Path = 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\AppHost'; Name = 'PreventOverride'; Type = 'DWord'; Value = 0 }
)

# Dynamic "Subscribed Content" Disable
$p = 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager'
Get-ItemProperty $p | Get-Member -MemberType NoteProperty | Where-Object {$_.Name -like "SubscribedContent-*Enabled"} | ForEach-Object {
    New-ItemProperty -Path $p -Name $_.Name -PropertyType DWord -Value 0 -Force | Out-Null
}