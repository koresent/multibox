Set-Package -Name voidtools.Everything.Alpha -Provider winget
$lnk = "$env:USERPROFILE\Desktop\Everything 1.5a.lnk"
if (Test-Path $lnk) {
	Remove-Item $lnk
}
Set-Config -Source "files\explorer-everything-integration" -Destination "${env:ProgramFiles(x86)}\Portable Apps\explorer-everything-integration"
Set-Config -Source "files\Everything-1.5a.ini" -Destination "$env:ProgramFiles\Everything 1.5a\Everything-1.5a.ini"