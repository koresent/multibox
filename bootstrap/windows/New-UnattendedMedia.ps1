$multiboxZipUrl = "https://github.com/koresent/multibox/archive/refs/heads/main.zip"
$multiboxZipPath = "$env:TEMP\multibox.zip"
$multiboxExtractedPath = "$env:TEMP\multibox-main"
$xmlPath = "$multiboxExtractedPath\bootstrap\windows\autounattend.xml"
$oemPath = "$multiboxExtractedPath\bootstrap\windows\sources\`$OEM`$"

$cursorsZipUrl = "https://github.com/koresent/Dot-Cursors/archive/refs/heads/main.zip"
$cursorsZipPath = "$env:TEMP\Dot-Cursors.zip"
$cursorsExtractedPath = "$env:TEMP\Dot-Cursors-main"
$whitePath = "$cursorsExtractedPath\White\cursors"
$blackPath = "$cursorsExtractedPath\Black\cursors"

$profileUrl = "https://raw.githubusercontent.com/koresent/pwsh-profile/main/profile.ps1"

if (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]"Administrator")) {
    Write-Warning "This script requires administrator privileges. Please restart PowerShell as Administrator."
    break
}

Write-Host "[1/5] Scanning for Windows bootable media..." -ForegroundColor Cyan

$usbDrives = Get-Disk | Where-Object { $_.BusType -eq 'USB' -and $_.OperationalStatus -eq 'Online' }
$validUsb = [System.Collections.ArrayList]::new()

foreach ($drive in $usbDrives) {
    foreach ($partition in (Get-Partition -DiskNumber $drive.Number | Where-Object { $_.DriveLetter })) {
        if ((Test-Path "$($partition.DriveLetter)\sources\install.wim") -or (Test-Path "$($partition.DriveLetter)\sources\install.esd")) {
            [void]$validUsb.Add(
                [PSCustomObject]@{
                    Name = $drive.FriendlyName
                    DriveLetter = $partition.DriveLetter
                    Size = $partition.Size
                }
            )
        }
    }
}

if ($validUsb.Count -eq 0) {
    throw "No suitable USB drives found. Use Rufus to prepare one: https://rufus.ie"
}
else {
   $target = $validUsb | Out-GridView -Title '' -OutputMode Single
   if (!$target) { throw "Selection cancelled by user" }
}

Write-Host "[2/5] Downloading configuration from GitHub..." -ForegroundColor Cyan
try {
    Invoke-RestMethod -Uri $multiboxZipUrl -OutFile $multiboxZipPath
    Invoke-RestMethod -Uri $cursorsZipUrl -OutFile $cursorsZipPath
	Invoke-RestMethod -Uri $profileUrl -OutFile "$($target.DriveLetter):\sources\`$OEM`$\`$`$\Setup\Resources\profile.ps1"
} catch {
    throw "Download error: $_"
}

Write-Host "[3/5] Extracting..." -ForegroundColor Cyan
Expand-Archive -Path $multiboxZipPath -DestinationPath $env:TEMP -Force
Expand-Archive -Path $cursorsZipPath -DestinationPath $env:TEMP -Force

Write-Host "[4/5] Patching USB drive..." -ForegroundColor Cyan
Copy-Item -Path $xmlPath -Destination "$($target.DriveLetter):\" -Force
Copy-Item -Path $oemPath -Destination "$($target.DriveLetter):\sources\" -Recurse -Force
New-Item -Path "$($target.DriveLetter):\sources\`$OEM`$\`$`$\Setup\Resources\Cursors" -ItemType Directory | Out-Null
Copy-Item -Path $whitePath -Destination "$($target.DriveLetter):\sources\`$OEM`$\`$`$\Setup\Resources\Cursors\Dot-White" -Recurse
Copy-Item -Path $blackPath -Destination "$($target.DriveLetter):\sources\`$OEM`$\`$`$\Setup\Resources\Cursors\Dot-Black" -Recurse

Write-Host "[5/5] Cleaning up..." -ForegroundColor Cyan
Remove-Item -Path $multiboxZipPath, $multiboxExtractedPath, $cursorsZipPath, $cursorsExtractedPath -Recurse -Force

Write-Host "`nSUCCESS! USB Drive $($target.DriveLetter): is now Unattended-ready." -ForegroundColor Green -BackgroundColor Black