Add-Type -AssemblyName System.Drawing

# Settings
$Width = 3840
$Height = 2160
$HexRadius = 90
$SpawnChance = 0.30
$OpacityMin = 30
$OpacityMax = 70

# Palette
$BgColorHex = "#282828"
$GruvboxAccents = @(
    "#cc241d", "#98971a", "#d79921", "#458588", 
    "#b16286", "#689d6a", "#d65d0e", 
    "#ebdbb2", "#928374"
)

function Get-ColorFromHex ($hex) {
    return [System.Drawing.ColorTranslator]::FromHtml($hex)
}

function Get-HexPoints ([float]$cx, [float]$cy, [float]$r) {
    $points = @()
    for ($angle = 30; $angle -lt 390; $angle += 60) {
        $rad = $angle * [Math]::PI / 180
        $x = $cx + $r * [Math]::Cos($rad)
        $y = $cy + $r * [Math]::Sin($rad)
        $points += New-Object System.Drawing.PointF($x, $y)
    }
    return ,$points # !
}

# Canvas
$Bitmap = New-Object System.Drawing.Bitmap($Width, $Height)
$Graphics = [System.Drawing.Graphics]::FromImage($Bitmap)

# Quality
$Graphics.SmoothingMode = [System.Drawing.Drawing2D.SmoothingMode]::HighQuality
$Graphics.PixelOffsetMode = [System.Drawing.Drawing2D.PixelOffsetMode]::HighQuality
$Graphics.CompositingQuality = [System.Drawing.Drawing2D.CompositingQuality]::HighQuality

# Background
$Graphics.Clear((Get-ColorFromHex $BgColorHex))

# Objects Logic
$Rnd = New-Object System.Random

$HexWidth = [Math]::Sqrt(3) * $HexRadius
$VertSpacing = $HexRadius * 1.5

$Rows = [Math]::Ceiling($Height / $VertSpacing) + 2
$Cols = [Math]::Ceiling($Width / $HexWidth) + 2

for ($row = -1; $row -lt $Rows; $row++) {
    for ($col = -1; $col -lt $Cols; $col++) {
        
        if ($Rnd.NextDouble() -gt $SpawnChance) { continue }

        $CurrentY = $row * $VertSpacing
        $CurrentX = $col * $HexWidth
        
        if ([Math]::Abs($row % 2) -eq 1) {
            $CurrentX += $HexWidth / 2
        }

        $RandomHex = $GruvboxAccents[$Rnd.Next(0, $GruvboxAccents.Count)]
        $Alpha = $Rnd.Next($OpacityMin, $OpacityMax)
        $ShapeColor = [System.Drawing.Color]::FromArgb($Alpha, (Get-ColorFromHex $RandomHex))
        $ShapeBrush = New-Object System.Drawing.SolidBrush($ShapeColor)

        $Points = Get-HexPoints $CurrentX $CurrentY $HexRadius
        $Graphics.FillPolygon($ShapeBrush, $Points)
        
        $ShapeBrush.Dispose()
    }
}

$OutputPath = "$env:SystemRoot\Setup\Resources\Lockscreen.png"
$Bitmap.Save($OutputPath, [System.Drawing.Imaging.ImageFormat]::Png)

$Graphics.Dispose()
$Bitmap.Dispose()