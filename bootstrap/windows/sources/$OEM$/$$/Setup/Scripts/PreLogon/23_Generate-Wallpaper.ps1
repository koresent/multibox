Add-Type -AssemblyName System.Drawing

# Settings
$Width = 3840        
$Height = 2160      
$ShapeCount = 6 

# Palette
$BgColorHex = "#282828"
$GruvboxAccents = @(
    "#cc241d", "#98971a", "#d79921", "#458588", 
    "#b16286", "#689d6a", "#d65d0e"
)

function Get-ColorFromHex ($hex) {
    return [System.Drawing.ColorTranslator]::FromHtml($hex)
}

# Canvas
$Bitmap = New-Object System.Drawing.Bitmap($Width, $Height)
$Graphics = [System.Drawing.Graphics]::FromImage($Bitmap)

# Quality
$Graphics.SmoothingMode = [System.Drawing.Drawing2D.SmoothingMode]::HighQuality
$Graphics.PixelOffsetMode = [System.Drawing.Drawing2D.PixelOffsetMode]::HighQuality
$Graphics.CompositingQuality = [System.Drawing.Drawing2D.CompositingQuality]::HighQuality
$Graphics.TextRenderingHint = [System.Drawing.Text.TextRenderingHint]::AntiAliasGridFit

# Background
$BgColor = Get-ColorFromHex $BgColorHex
$Graphics.Clear($BgColor)

# Objects Logic
$Rnd = New-Object System.Random
$PlacedCircles = @()

For ($i = 0; $i -lt $ShapeCount; $i++) {
    $ValidPosition = $false
    $Attempts = 0
    $MaxAttempts = 50
    
    do {
        $Size = $Rnd.Next([int]($Width * 0.10), [int]($Width * 0.30))
        $Radius = $Size / 2
        
        $X = $Rnd.Next(0, $Width - $Size)
        $Y = $Rnd.Next(0, $Height - $Size)
        
        $CenterX = $X + $Radius
        $CenterY = $Y + $Radius
        
        $HasCollision = $false
        foreach ($Circle in $PlacedCircles) {
            $DistX = $CenterX - $Circle.CenterX
            $DistY = $CenterY - $Circle.CenterY
            $Distance = [Math]::Sqrt($DistX*$DistX + $DistY*$DistY)
            
            if ($Distance -lt ($Radius + $Circle.Radius + 50)) {
                $HasCollision = $true
                break
            }
        }
        
        if (-not $HasCollision) {
            $ValidPosition = $true
        }
        
        $Attempts++
    } while (-not $ValidPosition -and $Attempts -lt $MaxAttempts)
    
    if ($ValidPosition -or $Attempts -ge $MaxAttempts) {
        
        $PlacedCircles += [PSCustomObject]@{
            CenterX = $CenterX
            CenterY = $CenterY
            Radius  = $Radius
        }

        $RandomHex = $GruvboxAccents[$Rnd.Next(0, $GruvboxAccents.Count)]
        $BaseColor = Get-ColorFromHex $RandomHex
        $Alpha = $Rnd.Next(20, 50)
        
        $ShapeColor = [System.Drawing.Color]::FromArgb($Alpha, $BaseColor)
        $ShapeBrush = New-Object System.Drawing.SolidBrush($ShapeColor)
        
        $Graphics.FillEllipse($ShapeBrush, $X, $Y, $Size, $Size)
        $ShapeBrush.Dispose()
    }
}

$OutputPath = "$env:SystemRoot\Setup\Resources\Wallpaper.png"
$Bitmap.Save($OutputPath, [System.Drawing.Imaging.ImageFormat]::Png)

$Graphics.Dispose()
$Bitmap.Dispose()