if (!(Test-Path "$env:ProgramFiles\ImageMagick-*\unins000.exe" -ErrorAction SilentlyContinue)) {
    $asset = ((Invoke-RestMethod 'https://api.github.com/repos/ImageMagick/ImageMagick/releases/latest').assets | Where-Object { $_.name -match 'ImageMagick-.*-Q16-HDRI-x64-dll\.exe$' })[0].browser_download_url
    $path = "$env:TEMP\im-installer.exe"
    Invoke-WebRequest -Uri $asset -OutFile $path
    Start-Process -FilePath $path -ArgumentList "/VERYSILENT", "/NORESTART", "/ALLUSERS" -Wait -NoNewWindow
    Remove-Item -Path $path -Force
}