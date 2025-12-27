Set-Package -Name Valve.Steam -Provider winget
$lnk = "$env:PUBLIC\Desktop\Steam.lnk"
if (Test-Path $lnk) {
	Remove-Item $lnk
}

$repoUrl = "https://api.github.com/repos/SteamClientHomebrew/Millennium/releases/latest"
$extendiumRepo = "https://api.github.com/repos/BossSloth/Extendium/releases/latest"
$steamPath = "C:\Program Files (x86)\Steam"
$tempZip = "$env:TEMP\millennium_install.zip"
$tempExtZip = "$env:TEMP\extendium_install.zip"
$pluginsPath = Join-Path -Path $steamPath -ChildPath "plugins"

if (!(Test-Path "$steamPath\millennium.dll")) {
    try {
        Get-Process -Name "steam" -ErrorAction SilentlyContinue | Stop-Process -Force

        $latestRelease = Invoke-RestMethod -Uri $repoUrl
        $asset = $latestRelease.assets | Where-Object { $_.name -match '^millennium-v.*-windows-x86_64\.zip$' } | Select-Object -First 1

        if (!($asset)) { throw "Release archive for Millennium not found!" }

        Invoke-WebRequest -Uri $asset.browser_download_url -OutFile $tempZip
        Expand-Archive -Path $tempZip -DestinationPath $steamPath -Force

        $debugFile = Join-Path -Path $steamPath -ChildPath ".cef-enable-remote-debugging"
        if (!(Test-Path -Path $debugFile)) {
            New-Item -Path $debugFile -ItemType File -Force | Out-Null
        }

        $extRelease = Invoke-RestMethod -Uri $extendiumRepo
        $extAsset = $extRelease.assets | Where-Object { $_.name -match '^Extendium-plugin-.*\.zip$' } | Select-Object -First 1

        if (!($extAsset)) { throw "Release archive for Extendium not found!" }

        Invoke-WebRequest -Uri $extAsset.browser_download_url -OutFile $tempExtZip

        if (!(Test-Path -Path $pluginsPath)) {
            New-Item -ItemType Directory -Path $pluginsPath -Force | Out-Null
        }

        Expand-Archive -Path $tempExtZip -DestinationPath $pluginsPath -Force

        Write-Host "Millennium and Extendium installed successfully."

    } catch {
        Write-Host "Error: $_"
    } finally {
        if (Test-Path -Path $tempZip) { Remove-Item -Path $tempZip -Force }
        if (Test-Path -Path $tempExtZip) { Remove-Item -Path $tempExtZip -Force }
    }
}