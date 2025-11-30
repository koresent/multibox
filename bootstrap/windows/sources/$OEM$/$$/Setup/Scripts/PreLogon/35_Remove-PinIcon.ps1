$sysResPath  = "$env:SystemRoot\SystemResources"
$targetFile  = "imageres.dll.mun"
$fullPath    = Join-Path $sysResPath $targetFile
$backupPath  = Join-Path $sysResPath "$targetFile.bak"
$workDir     = "$env:TEMP\IconPatcher_$(Get-Random)"
$patchedFile = Join-Path $workDir $targetFile
$rhExe       = "$env:SystemRoot\Setup\Resources\ResourceHacker.exe"
$iconFile    = "$env:SystemRoot\Setup\Resources\blank.ico"

try {
    if (!(Test-Path $rhExe)) { throw "ResourceHacker missing" }
    if (!(Test-Path $iconFile)) { throw "Icon file missing" }
    if (!(Test-Path $fullPath)) { throw "Target file missing" }

    takeown /f $sysResPath /a *>$null
    icacls $sysResPath /grant "Administrators:F" /q *>$null

    New-Item -ItemType Directory -Force -Path $workDir | Out-Null
    Copy-Item -Path $fullPath -Destination $patchedFile -ErrorAction Stop

    takeown /f $fullPath /a *>$null
    icacls $fullPath /grant "Administrators:F" /q *>$null

    if (!(Test-Path $backupPath)) {
        Copy-Item -Path $fullPath -Destination $backupPath -ErrorAction Stop
    }

    $p = New-Object System.Diagnostics.Process
    $p.StartInfo.FileName = $rhExe
    $p.StartInfo.Arguments = "-open `"$patchedFile`" -save `"$patchedFile`" -action addoverwrite -res `"$iconFile`" -mask ICONGROUP,5100,"
    $p.StartInfo.UseShellExecute = $false
    $p.StartInfo.CreateNoWindow = $true
    $p.StartInfo.RedirectStandardOutput = $true
    $p.StartInfo.RedirectStandardError = $true

    if (-not $p.Start()) { throw "Failed to start ResourceHacker process" }

    $stdOut = $p.StandardOutput.ReadToEnd()
    $stdErr = $p.StandardError.ReadToEnd()
    $p.WaitForExit()

    if ($p.ExitCode -ne 0) {
        throw "ResourceHacker failed (ExitCode: $($p.ExitCode)). `nStdOut: $stdOut `nStdErr: $stdErr"
    }

    if (-not (Test-Path $patchedFile)) {
        throw "Patched file creation failed"
    }

    $oldFileTemp = "$targetFile.old_$(Get-Random)"
    
    try {
        Rename-Item -Path $fullPath -NewName $oldFileTemp -Force -ErrorAction Stop
        Copy-Item -Path $patchedFile -Destination $fullPath -Force -ErrorAction Stop
    } 
    catch {
        if (Test-Path (Join-Path $sysResPath $oldFileTemp)) {
             Rename-Item -Path (Join-Path $sysResPath $oldFileTemp) -NewName $targetFile -Force -ErrorAction SilentlyContinue
        }
        throw "File replacement failed. System locked the file: $_"
    }

    Remove-Item (Join-Path $sysResPath $oldFileTemp) -Force -ErrorAction SilentlyContinue
}
catch {
    throw $_
}
finally {
    if (Test-Path $workDir) {
        Remove-Item $workDir -Recurse -Force -ErrorAction SilentlyContinue
    }
    if ($p) { $p.Dispose() }
}