Set-Package -Name Espanso.Espanso -Provider winget
Set-Config -Source "files\config" -Destination "$env:APPDATA\espanso\config"
Set-Config -Source "files\match" -Destination "$env:APPDATA\espanso\match"
Set-Config -Source "files\scripts" -Destination "$env:APPDATA\espanso\scripts"