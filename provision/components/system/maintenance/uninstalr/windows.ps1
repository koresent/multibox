$sPath = "$env:TEMP\Uninstalr_Setup.exe"

if (!(Test-Path "${env:ProgramFiles(x86)}\Uninstalr\Uninstalr.exe")) {
    try {
        Invoke-WebRequest "https://uninstalr.com/Uninstalr_Setup.exe" -OutFile $sPath
        
        $process = Start-Process -FilePath $sPath -ArgumentList "/S" -PassThru
        $process.WaitForExit()

        $timeoutSeconds = 15
        for ($i = 0; $i -lt $timeoutSeconds; $i++) {
            $proc = Get-Process -Name "Uninstalr" -ErrorAction SilentlyContinue
            if ($proc) {
                Stop-Process -InputObject $proc -Force -ErrorAction SilentlyContinue
                break
            }
            Start-Sleep -Seconds 1
        }
    }
    catch {
        Write-Error "Installation failed: $_"
    }
    finally {
        if (Test-Path $sPath) {
            Remove-Item $sPath -Force -ErrorAction SilentlyContinue
        }
    }
}
$lnk = "$env:PUBLIC\Desktop\Uninstalr.lnk"
if (Test-Path $lnk) {
	Remove-Item $lnk
}