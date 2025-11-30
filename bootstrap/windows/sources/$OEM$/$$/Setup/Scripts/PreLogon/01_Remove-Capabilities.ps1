$items = @(
    'Print.Fax.Scan',
    'Language.Handwriting',
    'Browser.InternetExplorer',
    'MathRecognizer',
    'OneCoreUAP.OneSync',
    'Microsoft.Windows.MSPaint',
    'Microsoft.Windows.PowerShell.ISE',
    'App.Support.QuickAssist',
    'Microsoft.Windows.SnippingTool',
    'Language.Speech',
    'Language.TextToSpeech',
    'App.StepsRecorder',
    'Media.WindowsMediaPlayer',
    'Microsoft.Windows.WordPad'
);

$capabilities = Get-WindowsCapability -Online

foreach ($item in $items) {
    $itemsFound = $capabilities | Where-Object { $_.Name -like "*$item*" -and $_.State -eq 'Installed' }

	foreach ($cap in $itemsFound) {
	    try {
			$cap | Remove-WindowsCapability -Online -ErrorAction Stop | Out-Null
		}
		catch {
			Write-Log "FAILED to remove $item. Error: $($_.Exception.Message)" "WARN"
		}
	}
}