Set-Package -Name WinsiderSS.SystemInformer -Provider winget
$lnk = "$env:PUBLIC\Desktop\System Informer.lnk"
if (Test-Path $lnk) {
	Remove-Item $lnk
}
Set-Config -Source "files\SystemInformer.exe.settings.xml" -Destination "$env:ProgramFiles\SystemInformer\SystemInformer.exe.settings.xml"
$Key = "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\taskmgr.exe"
$Val = '"C:\Program Files\SystemInformer\SystemInformer.exe"'

if ((Get-ItemProperty $Key Debugger -ErrorAction SilentlyContinue).Debugger -ne $Val) {
    New-Item $Key -Force | Out-Null
    Set-ItemProperty $Key Debugger $Val
}