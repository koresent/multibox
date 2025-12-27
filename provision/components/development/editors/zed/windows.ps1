Set-Package -Name ZedIndustries.Zed -Provider winget
Set-Config -Source "files\settings.json" -Destination "$env:APPDATA\Zed\settings.json"
Set-Config -Source "files\snippets" -Destination "$env:APPDATA\Zed\snippets"