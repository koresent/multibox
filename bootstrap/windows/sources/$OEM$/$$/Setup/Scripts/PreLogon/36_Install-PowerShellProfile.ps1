$src = "$env:SystemRoot\Setup\Resources\profile.ps1"
@("$env:SystemRoot\System32\WindowsPowerShell\v1.0\profile.ps1", "$env:ProgramFiles\PowerShell\7\profile.ps1") | Foreach-Object {
	$dir = Split-Path -Path $_ -Parent
	New-Item -Path $dir -ItemType Directory -Force | Out-Null
	Copy-Item -Path $src -Destination $_ -Force
}