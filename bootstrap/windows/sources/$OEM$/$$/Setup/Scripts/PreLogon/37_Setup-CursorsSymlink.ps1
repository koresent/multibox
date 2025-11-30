try {
	New-Item -Path "$env:SystemRoot\Cursors\Dot-White" -ItemType SymbolicLink -Target "$env:SystemRoot\Setup\Resources\Cursors\Dot-White" -Force -ErrorAction Stop | Out-Null
	New-Item -Path "$env:SystemRoot\Cursors\Dot-Black" -ItemType SymbolicLink -Target "$env:SystemRoot\Setup\Resources\Cursors\Dot-Black" -Force -ErrorAction Stop | Out-Null
} catch {}