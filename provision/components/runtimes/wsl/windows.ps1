if (!(Get-Command wsl -ErrorAction SilentlyContinue)) {
    Set-Package -Name Microsoft.WSL -Provider winget
}