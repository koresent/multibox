Set-Package -Name Giorgiotani.Peazip -Provider winget
$lnk = "$env:USERPROFILE\Desktop\PeaZip.lnk"
if (Test-Path $lnk) {
	Remove-Item $lnk
}
Set-Config -Source "files\conf.txt" -Destination "$env:APPDATA\PeaZip\conf.txt"
Set-Config -Source "files\Eleven" -Destination "$env:APPDATA\PeaZip\themes\Eleven"
$keyToRemove = "Registry::HKEY_CLASSES_ROOT\Directory\background\shell\Browse path with PeaZip"
if (Test-Path -Path $keyToRemove) {
    Remove-Item -Path $keyToRemove -Recurse -Force -ErrorAction SilentlyContinue
}