Set-Package -Name Zen-Team.Zen-Browser -Provider winget
$profiles = "$env:APPDATA\zen\Profiles"
if (!(Test-Path $profiles)) {
    $zenPath = "$env:ProgramFiles\Zen Browser\zen.exe"
	$proc = Start-Process -FilePath $zenPath -ArgumentList "--headless" -PassThru
	Start-Sleep -Seconds 5
	Stop-Process -InputObject $proc -Force
}
$profilePath = (Get-ChildItem $profiles -ErrorAction Stop | Where-Object {$_.Name -like "*(release)"})[0].FullName
if ($profilePath) {
    Set-Config -Source "files\user.js" -Destination "$profilePath\user.js"
    Set-Config -Source "files\zen-keyboard-shortcuts.json" -Destination "$profilePath\zen-keyboard-shortcuts.json"
    Set-Config -Source "files\zen-themes.json" -Destination "$profilePath\zen-themes.json"
    Set-Config -Source "files\chrome" -Destination "$profilePath\chrome"
}
else {
	Write-Host "Profile not found"
}