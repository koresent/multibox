Set-Package -Name Yaak.app -Provider winget
$lnk = "$env:USERPROFILE\Desktop\Yaak.lnk"
if (Test-Path $lnk) {
	Remove-Item $lnk
}