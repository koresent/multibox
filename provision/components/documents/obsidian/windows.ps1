Set-Package -Name Obsidian.Obsidian -Provider winget
$lnk = "$env:USERPROFILE\Desktop\Obsidian.lnk"
if (Test-Path $lnk) {
	Remove-Item $lnk
}