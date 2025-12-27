param(
    [int]$Count = 4
)

$WordlistPath = Join-Path $PSScriptRoot "eff_short_wordlist_1.txt"

if (!(Test-Path $WordlistPath)) {
    Write-Error "Dictionary not found at $WordlistPath"
    exit 1
}

$Password = (Get-Content -Path $WordlistPath -Encoding UTF8 | Get-Random -Count $Count) -join "-"

$Password | Set-Clipboard

Write-Output $Password