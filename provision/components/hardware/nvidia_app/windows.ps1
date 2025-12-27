if (!(Test-Path "$env:ProgramFiles\NVIDIA Corporation\NVIDIA app\CEF\NVIDIA app.exe" -ErrorAction SilentlyContinue) -and (Get-CimInstance Win32_VideoController | Where-Object { $_.Name -match 'NVIDIA' })) {
    $page = Invoke-WebRequest -Uri "https://www.nvidia.com/en-us/software/nvidia-app/" -UseBasicParsing
    if ($page.Content -match 'https://us\.download\.nvidia\.com/nvapp/client/[0-9\.]+/NVIDIA_app_v[0-9\.]+\.exe') {
        $url = $matches[0]
        $path = "$env:TEMP\nvidia-app-installer.exe"
        Invoke-WebRequest -Uri $url -OutFile $path
        Start-Process -FilePath $path -ArgumentList "-s", "-noreboot", "-noeula", "-nofinish", "-nosplash" -Wait -NoNewWindow
        Remove-Item -Path $path -Force
    }
}