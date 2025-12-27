param (
    [string]$amount = "1",
    [string]$from = "usd",
    [string]$to = "rub"
)

$from = $from.ToLower()
$to = $to.ToLower()

$url = "https://cdn.jsdelivr.net/npm/@fawazahmed0/currency-api@latest/v1/currencies/$from.json"

try {
    $data = Invoke-RestMethod -Uri $url -Method Get
    $rate = $data.$from.$to

    $result = [math]::Round(([double]$amount * $rate), 0)
    Write-Output $result
} catch {
    Write-Output "Error"
}