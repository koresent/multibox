Set-Package -Name tenacity -Provider chocolatey
$lnk = "$env:PUBLIC\Desktop\Tenacity.lnk"
if (Test-Path $lnk) {
	Remove-Item $lnk
}