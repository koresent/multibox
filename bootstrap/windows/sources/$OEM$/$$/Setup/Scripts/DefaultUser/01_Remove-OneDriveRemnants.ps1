$p = "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Run"
if (Get-ItemProperty -Path $p -Name "OneDriveSetup" -ErrorAction SilentlyContinue) {
    Remove-ItemProperty -Path $p -Name "OneDriveSetup" -Force -ErrorAction Stop
}