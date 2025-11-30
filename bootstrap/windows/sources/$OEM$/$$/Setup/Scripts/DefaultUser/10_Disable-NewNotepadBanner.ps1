Set-RegistryConfiguration -Items @(
    [PSCustomObject]@{ Path = 'HKCU:\SOFTWARE\Microsoft\Notepad'; Name = 'ShowStoreBanner'; Type = 'DWord'; Value = 0 }
)