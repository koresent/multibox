Set-Package -Name Inkscape.Inkscape -Provider winget
$lnk = "$env:PUBLIC\Desktop\Inkscape.lnk"
if (Test-Path $lnk) {
	Remove-Item $lnk
}