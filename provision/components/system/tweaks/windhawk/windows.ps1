Set-Package -Name RamenSoftware.Windhawk -Provider winget
$lnk = "$env:PUBLIC\Desktop\Windhawk.lnk"
if (Test-Path $lnk) {
	Remove-Item $lnk
}