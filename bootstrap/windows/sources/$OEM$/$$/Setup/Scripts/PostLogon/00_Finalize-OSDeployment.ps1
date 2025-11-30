Set-RegistryConfiguration -Items @(
    [PSCustomObject]@{ Path = 'HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon'; Name = 'AutoLogonCount'; Type = 'DWord'; Value = 0 }
)

Remove-Item -Path "$env:SystemDrive\Windows.old", "$env:SystemDrive\inetpub", "$env:SystemDrive\PerfLogs", "$env:SystemRoot\Panther\*unattend*.xml" -Recurse -Force -ErrorAction SilentlyContinue

Get-ChildItem "$env:PUBLIC\Desktop" | Remove-Item -ErrorAction SilentlyContinue