Set-Package -Name Flameshot.Flameshot -Provider winget
$lnk = "$env:USERPROFILE\Desktop\Flameshot.lnk"
if (Test-Path $lnk) {
	Remove-Item $lnk
}