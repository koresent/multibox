Set-Package -Name ONLYOFFICE.DesktopEditors -Provider winget
$lnk = "$env:PUBLIC\Desktop\ONLYOFFICE.lnk"
if (Test-Path $lnk) {
	Remove-Item $lnk
}
$svc = "ONLYOFFICE Update Service"
$chk = Get-Service -Name $svc -ErrorAction SilentlyContinue
if ($chk.StartType -ne 'Disabled') {
	Stop-Service -Name $svc -Force -ErrorAction SilentlyContinue
	Set-Service -Name $svc -StartupType Disabled -ErrorAction SilentlyContinue
}