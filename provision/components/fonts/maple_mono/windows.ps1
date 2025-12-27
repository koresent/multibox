if (!(Test-Path "C:\Windows\Fonts\MapleMono-NF-Regular.ttf")) {
    try {
        $url = (Invoke-RestMethod -Uri "https://api.github.com/repos/subframe7536/maple-font/releases/latest").assets | Where-Object { $_.name -eq "MapleMono-NF-unhinted.zip" }
        
        if ($url) {
            $zip = "$env:TEMP\maple.zip"
            $extract = "$env:TEMP\maple_tmp"
            
            Invoke-WebRequest -Uri $url.browser_download_url -OutFile $zip
            Expand-Archive -Path $zip -DestinationPath $extract -Force
            
            Get-ChildItem -Path $extract -Recurse -Filter "*.ttf" | ForEach-Object {
                Copy-Item -Path $_.FullName -Destination "C:\Windows\Fonts" -Force
                New-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Fonts" -Name ($_.Name + " (TrueType)") -Value $_.Name -PropertyType String -Force | Out-Null
            }
            
            Remove-Item -Path $zip, $extract -Recurse -Force -ErrorAction SilentlyContinue
        }
    } catch {}
}