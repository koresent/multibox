Set-Package -Name AdGuard.AdGuard -Provider winget
$lnk = "$env:PUBLIC\Desktop\AdGuard.lnk"
if (Test-Path $lnk) {
	Remove-Item $lnk
}