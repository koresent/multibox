Set-Package -Name SpikeHD.Dorion -Provider winget
Set-Config -Source "files\config.json" -Destination "$env:APPDATA\dorion\config.json"
Set-Config -Source "files\themes" -Destination "$env:USERPROFILE\dorion\themes"