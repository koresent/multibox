Set-Package -Name beekeeper-studio.beekeeper-studio -Provider winget
$lnk = "$env:USERPROFILE\Desktop\Beekeeper Studio.lnk"
if (Test-Path $lnk) {
	Remove-Item $lnk
}