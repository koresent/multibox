Set-Package -Name mpv.net -Provider winget
Set-Config -Source "files\fonts" -Destination "$env:APPDATA\mpv.net\fonts"
Set-Config -Source "files\scripts" -Destination "$env:APPDATA\mpv.net\scripts"
Set-Config -Source "files\mpv.conf" -Destination "$env:APPDATA\mpv.net\mpv.conf"