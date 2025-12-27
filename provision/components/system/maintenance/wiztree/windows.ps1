Set-Package -Name AntibodySoftware.WizTree -Provider winget
$lnk = "$env:USERPROFILE\Desktop\WizTree.lnk"
if (Test-Path $lnk) {
	Remove-Item $lnk
}