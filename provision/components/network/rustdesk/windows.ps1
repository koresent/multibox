Set-Package -Name RustDesk.RustDesk -Provider winget
$lnk = "$env:PUBLIC\Desktop\RustDesk.lnk"
if (Test-Path $lnk) {
	Remove-Item $lnk
}
$svc = "RustDesk"
$chk = Get-Service -Name $svc -ErrorAction SilentlyContinue
if ($chk.StartType -ne 'Disabled') {
	Stop-Service -Name $svc -Force -ErrorAction SilentlyContinue
	Set-Service -Name $svc -StartupType Disabled -ErrorAction SilentlyContinue
}