$items = @(
    "*Microsoft.Xbox*",
    "*Microsoft.GamingApp*",
    "*Microsoft.Bing*",
    "*Microsoft.GetHelp*",
    "*Microsoft.Getstarted*",
    "*Microsoft.Microsoft3DViewer*",
    "*Microsoft.MicrosoftOfficeHub*",
    "*Microsoft.MicrosoftSolitaireCollection*",
    "*Microsoft.MixedReality.Portal*",
    "*Microsoft.MSPaint*",
    "*Microsoft.Office.OneNote*",
    "*Microsoft.People*",
    "*Microsoft.Wallet*",
    "*Microsoft.WindowsFeedbackHub*",
    "*Microsoft.WindowsMaps*",
    "*Microsoft.WindowsSoundRecorder*",
    "*Microsoft.YourPhone*",
    "*Microsoft.ZuneMusic*",
    "*Microsoft.ZuneVideo*",
    "*Microsoft.SkypeApp*",
    "*Microsoft.YourPhone*",
    "*microsoft.windowscommunicationsapps*",
    "*Microsoft.WindowsCamera*",
    "*Microsoft.OneConnect*",
    "*Microsoft.Messaging*",
    "*Microsoft.Todos*",
    "*MicrosoftTeams*",
    "*Microsoft.PowerAutomateDesktop*",
    "*Clipchamp.Clipchamp*",
    "*MicrosoftCorporationII.MicrosoftFamily*",
    "*MicrosoftCorporationII.QuickAssist*",
    "*MSTeams*",
    "*Microsoft.OutlookForWindows*",
    "*Microsoft.Windows.DevHome*",
    "*Microsoft.Copilot*",
    "*MicrosoftWindows.Client.AIX*",
    "*MicrosoftWindows.Client.CoPilot*",
    "*Microsoft.Windows.Ai.Copilot.Provider*",
    "*MicrosoftWindows.Client.Photon*",
    "*Microsoft.549981C3F5F10*",
	"*Yandex.Music*",
	"*Microsoft.ScreenSketch*",
	"*Microsoft.Paint*",
	"*Microsoft.WindowsNotepad*",
	"*Microsoft.WindowsTerminal*",
	"*Microsoft.Windows.Photos*",
	"*MicrosoftWindows.CrossDevice*",
	"*Microsoft.MicrosoftStickyNotes*"
)

$provisioned = Get-AppxProvisionedPackage -Online

foreach ($item in $items) {
    $candidates = $provisioned | Where-Object { $_.DisplayName -like $item }

    foreach ($app in $candidates) {
        try {
            Remove-AppxProvisionedPackage -Online -PackageName $app.PackageName -ErrorAction Stop | Out-Null
        } catch {}
    }
}

$installed = Get-AppxPackage -AllUsers

foreach ($item in $items) {
    $candidates = $installed | Where-Object { ($_.Name -like $item) -and (-not $_.NonRemovable) -and (-not $_.IsFramework) }

    foreach ($app in $candidates) {
        try {
            Remove-AppxPackage -Package $app.PackageFullName -AllUsers -ErrorAction Stop | Out-Null
        } catch {}
    }
}