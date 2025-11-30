$adkPath = "${env:ProgramFiles(x86)}\Windows Kits\10\Assessment and Deployment Kit\Deployment Tools\amd64\Oscdimg\oscdimg.exe"
$sourcePath = "$PSScriptRoot\w11_src"
$targetIso = "$PSScriptRoot\w11_unattended.iso"

if (!(Test-Path -LiteralPath $adkPath)) {
    Write-Host "Error: ADK tool (oscdimg.exe) not found at: $adkPath" -ForegroundColor Red
    Read-Host "Press Enter to exit..."
    exit 1
}

if (!(Test-Path -LiteralPath "$sourcePath\boot\etfsboot.com") -or !(Test-Path -LiteralPath "$sourcePath\efi\microsoft\boot\efisys.bin")) {
    Write-Host "Error: Boot files are missing in Source folder." -ForegroundColor Red
    Read-Host "Press Enter to exit..."
    exit 1
}

$BootData = "2#p0,e,b$sourcePath\boot\etfsboot.com#pEF,e,b$sourcePath\efi\microsoft\boot\efisys.bin"

$oscdimgArgs = @(
    "-m",
    "-o",
    "-u2",
    "-udfver102",
    "-bootdata:$BootData",
    "$sourcePath",
    "$targetIso"
)

& $adkPath $oscdimgArgs

if ($LASTEXITCODE -eq 0) {
    Write-Host "Success: $targetIso" -ForegroundColor Green
} else {
    Write-Host "FAILED. Exit code: $LASTEXITCODE" -ForegroundColor Red
}

Read-Host "Press Enter to exit..."