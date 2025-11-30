$items = @(
    'MediaPlayback',
    'MicrosoftWindowsPowerShellV2Root',
    'Recall',
    'Microsoft-SnippingTool'
);

$features = Get-WindowsOptionalFeature -Online

foreach ($item in $items) {
    $itemsFound = $features | Where-Object { $_.FeatureName -like "*$item*" -and $_.State -eq 'Enabled' }

    foreach ($feat in $itemsFound) {
        try {
            Disable-WindowsOptionalFeature -Online -FeatureName $feat.FeatureName -Remove -NoRestart -ErrorAction Stop -WarningAction SilentlyContinue | Out-Null
        }
        catch {
            Write-Log "FAILED to disable $item. Error: $($_.Exception.Message)" "WARN"
        }
    }
}