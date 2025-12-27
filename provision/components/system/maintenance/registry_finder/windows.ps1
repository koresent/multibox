Set-Package -Name SergeyFilippov.RegistryFinder -Provider winget

$Key = "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\regedit.exe"
$Val = '"C:\Program Files\Registry Finder\RegistryFinder.exe" -z'

if ((Get-ItemProperty $Key Debugger -ErrorAction SilentlyContinue).Debugger -ne $Val) {
    New-Item $Key -Force | Out-Null
    Set-ItemProperty $Key Debugger $Val
}