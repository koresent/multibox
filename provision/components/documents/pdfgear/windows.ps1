# if (!(Test-Path "$env:ProgramFiles\PDFgear\PDFLauncher.exe" -ErrorAction SilentlyContinue)) {
#     $page = Invoke-WebRequest -Uri "https://www.pdfgear.com/download/" -UseBasicParsing
#     if ($page.Content -match 'https://downloadfiles\.pdfgear\.com/releases/windows/pdfgear_setup_v[\d\.]+\.exe') {
#         $url = $matches[0]
#         $path = "$env:TEMP\pdfgear-setup.exe"
#         Invoke-WebRequest -Uri $url -OutFile $path
#         Start-Process -FilePath $path -ArgumentList "/VERYSILENT", "/NORESTART", "/ALLUSERS" -Wait -NoNewWindow
#         Remove-Item -Path $path -Force
#     }
# }
Set-Package -Name PDFgear.PDFgear -Provider winget
$lnk = "$env:PUBLIC\Desktop\PDFgear.lnk"
if (Test-Path $lnk) {
	Remove-Item $lnk
}