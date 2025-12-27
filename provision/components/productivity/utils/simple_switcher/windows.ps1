$folderPath = "$env:ProgramFiles\SimpleSwitcher"
if (!(Test-Path $folderPath -ErrorAction SilentlyContinue)) {
    $asset = (Invoke-RestMethod "https://api.github.com/repos/Aegel5/SimpleSwitcher/releases/latest").assets | Where-Object { $_.name -match 'SimpleSwitcher_x64_.*.zip$' }
    New-Item -Path $folderPath -Type Directory -Force | Out-Null
	$archivePath = "$folderPath\$($asset.name)"
    Invoke-WebRequest -Uri $asset.browser_download_url -OutFile $archivePath
    Expand-Archive -LiteralPath $archivePath -DestinationPath $folderPath
	Remove-Item -Path $archivePath
	Set-ItemProperty -Path "HKLM:\Software\Microsoft\Windows\CurrentVersion\Run" -Name "SimpleSwitcher" -Value "$folderPath\SimpleSwitcher.exe"
}
Set-Config -Source "files\SimpleSwitcher.json" -Destination "$folderPath\SimpleSwitcher.json"
Set-Config -Source "files\Twemoji" -Destination "$folderPath\flags\Twemoji"