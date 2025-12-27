Set-Package -Name WinMerge.WinMerge -Provider winget
Set-Config -Source "files\Gruvbox Dark.ini" -Destination "$env:ProgramFiles\WinMerge\ColorSchemes\Gruvbox Dark.ini"
Set-Config -Source "files\winmerge.ini" -Destination "$env:ProgramFiles\WinMerge\winmerge.ini"