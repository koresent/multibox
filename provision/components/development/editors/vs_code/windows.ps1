Set-Package -Name Microsoft.VisualStudioCode -Provider winget
$extListPath = "$env:APPDATA\Code\User\extensions.list"
if (!(Test-Path $extListPath) -or (((Get-FileHash -Path "files\extensions.list" -Algorithm SHA256).Hash) -ne ((Get-FileHash -Path $extListPath -Algorithm SHA256).Hash))) {
	$null = New-Item -Path (Split-Path $extListPath -Parent) -ItemType Directory -Force
	Copy-Item "files\extensions.list" $extListPath -Force
	$extList = Get-Content $extListPath
	$extList | Foreach-Object {
		code --install-extension "$_" --force
	}
}
Set-Config -Source "files\settings.json" -Destination "$env:APPDATA\Code\User\settings.json"