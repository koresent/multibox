Set-Package -Name qBittorrent.qBittorrent -Provider winget
Set-Config -Source "files\themes" -Destination "$env:ProgramFiles\qBittorrent\themes"
Set-Config -Source "files\qBittorrent.ini" -Destination "$env:APPDATA\qBittorrent\qBittorrent.ini"