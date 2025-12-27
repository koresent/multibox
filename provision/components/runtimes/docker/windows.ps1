Set-Package -Name Docker.DockerDesktop -Provider winget
$lnk = "$env:USERPROFILE\Desktop\Docker Desktop.lnk"
if (Test-Path $lnk) {
	Remove-Item $lnk
}
$rPath = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Run"
$rName = "Docker Desktop"

if (Get-ItemProperty -Path $rPath -Name $rName -ErrorAction SilentlyContinue) {
	Remove-ItemProperty -Path $rPath -Name $rName -Force
}

$sPath = "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\Docker Backend.lnk"
if (!(Test-Path $sPath)) {
    $s = (New-Object -ComObject WScript.Shell).CreateShortcut($sPath)
    $s.TargetPath = "$env:ProgramFiles\Docker\Docker\resources\com.docker.backend.exe"
    $s.WorkingDirectory = "$env:ProgramFiles\Docker\Docker\resources"
    $s.Arguments = "-with-frontend=false"
    $s.IconLocation = "$env:ProgramFiles\Docker\Docker\Docker Desktop.exe,0"
    $s.Save()
}