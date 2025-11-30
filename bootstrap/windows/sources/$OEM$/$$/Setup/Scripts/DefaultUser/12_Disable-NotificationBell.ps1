Set-RegistryConfiguration -Items @(
    [PSCustomObject]@{ Path = 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced'; Name = 'ShowNotificationIcon'; Type = 'DWord'; Value = 0 }
)