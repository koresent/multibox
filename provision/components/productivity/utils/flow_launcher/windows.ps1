Set-Package -Name Flow-Launcher.Flow-Launcher -Provider winget
$lnk = "$env:USERPROFILE\Desktop\Flow Launcher.lnk"
if (Test-Path $lnk) {
	Remove-Item $lnk
}
Set-Config -Source "files\Plugins" -Destination "$env:APPDATA\FlowLauncher\Plugins"
Set-Config -Source "files\Settings\Settings.json" -Destination "$env:APPDATA\FlowLauncher\Settings.json"
Set-Config -Source "files\Settings\Plugins" -Destination "$env:APPDATA\FlowLauncher\Plugins"
Set-Config -Source "files\Themes" -Destination "$env:APPDATA\FlowLauncher\Themes"