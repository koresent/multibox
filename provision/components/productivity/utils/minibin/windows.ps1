$folderPath = "${env:ProgramFiles(x86)}\MiniBin"
if (!(Test-Path $folderPath -ErrorAction SilentlyContinue)) {
	Set-Config -Source "files\MiniBin" -Destination $folderPath
	Set-ItemProperty -Path "HKLM:\Software\Microsoft\Windows\CurrentVersion\Run" -Name "MiniBin" -Value "$folderPath\MiniBin.exe"
}