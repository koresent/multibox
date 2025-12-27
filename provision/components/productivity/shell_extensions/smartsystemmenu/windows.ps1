Set-Package -Name AlexanderPro.SmartSystemMenu -Provider winget
if (!(Get-ItemProperty "HKLM:\Software\Microsoft\Windows\CurrentVersion\Run" "SmartSystemMenu" -ea 0)) {
    Set-ItemProperty -Path "HKLM:\Software\Microsoft\Windows\CurrentVersion\Run" -Name "SmartSystemMenu" -Value "$env:USERPROFILE\AppData\Local\Microsoft\WinGet\Packages\AlexanderPro.SmartSystemMenu_Microsoft.Winget.Source_8wekyb3d8bbwe\SmartSystemMenu.exe"
}