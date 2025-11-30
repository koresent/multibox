Add-Type -AssemblyName System.Drawing

# Settings
$DestPath = "$env:ProgramData\Microsoft\User Account Pictures"
$TempSourcePath = "$env:TEMP\profile.png"
$BackupPath = "$DestPath\Backup_$(Get-Date -Format 'yyyy-MM-dd')"
$width = 448
$height = 448
$bgColorHex = "#1f2020"

$bmp = New-Object System.Drawing.Bitmap $width, $height
$g = [System.Drawing.Graphics]::FromImage($bmp)
$g.SmoothingMode = [System.Drawing.Drawing2D.SmoothingMode]::HighQuality
$g.InterpolationMode = [System.Drawing.Drawing2D.InterpolationMode]::HighQualityBicubic

# Background
$bgColor = [System.Drawing.ColorTranslator]::FromHtml($bgColorHex)
$g.Clear($bgColor)

$rnd = New-Object Random

# Accent
$rBase = $rnd.Next(60, 100)
$gBase = $rnd.Next(10, 40)
$bBase = $rnd.Next(120, 180)

function Draw-SoftGlow {
    param($graphics, $x, $y, $radius, $alpha, $scale)

    $path = New-Object System.Drawing.Drawing2D.GraphicsPath

    $rect = New-Object System.Drawing.RectangleF ($x - $radius), ($y - $radius), ($radius * 2), ($radius * 2)
    $path.AddEllipse($rect)

    $pgb = New-Object System.Drawing.Drawing2D.PathGradientBrush $path
    $pgb.CenterColor = [System.Drawing.Color]::FromArgb($alpha, $rBase, $gBase, $bBase)
    $pgb.SurroundColors = @([System.Drawing.Color]::Transparent)
    $pgb.FocusScales = New-Object System.Drawing.PointF $scale, $scale

    $graphics.FillEllipse($pgb, $rect)
}

$centerX = $width / 2
$centerY = $height / 2

# Base glow 
Draw-SoftGlow -graphics $g -x $centerX -y $centerY -radius 380 -alpha 40 -scale 0.9

# Middle glow
Draw-SoftGlow -graphics $g -x $centerX -y $centerY -radius 240 -alpha 60 -scale 0.6

# Core
$coreColor = [System.Drawing.Color]::FromArgb(100, ($rBase + 40), ($gBase + 20), ($bBase + 40))
$pathCore = New-Object System.Drawing.Drawing2D.GraphicsPath
$pathCore.AddEllipse([float]($centerX - 60), [float]($centerY - 60), 120.0, 120.0)
$pgbCore = New-Object System.Drawing.Drawing2D.PathGradientBrush $pathCore
$pgbCore.CenterColor = $coreColor
$pgbCore.SurroundColors = @([System.Drawing.Color]::Transparent)
$pgbCore.FocusScales = New-Object System.Drawing.PointF 0.2, 0.2
$g.FillEllipse($pgbCore, [float]($centerX - 60), [float]($centerY - 60), 120.0, 120.0)

# Sparks
for ($i = 0; $i -lt 80; $i++) {
    $sx = $rnd.Next(0, $width)
    $sy = $rnd.Next(0, $height)
    $dist = [Math]::Sqrt([Math]::Pow($sx - $centerX, 2) + [Math]::Pow($sy - $centerY, 2))
    
    if ($dist -lt 220 -and $dist -gt 20) {
        $size = $rnd.NextDouble() * 2.5
        $sparkAlpha = $rnd.Next(50, 200)
        if ($rnd.Next(0, 2) -eq 0) { $sparkColor = [System.Drawing.Color]::FromArgb($sparkAlpha, 255, 255, 255) } 
        else { $sparkColor = [System.Drawing.Color]::FromArgb($sparkAlpha, 200, 180, 255) }
        
        $brushSpark = New-Object System.Drawing.SolidBrush $sparkColor
        $g.FillEllipse($brushSpark, [float]$sx, [float]$sy, [float]$size, [float]$size)
    }
}

# Save temp source
$bmp.Save($TempSourcePath, [System.Drawing.Imaging.ImageFormat]::Png)
$g.Dispose()
$bmp.Dispose()

# Resize & Convert Function
function Resize-Image {
    param([string]$Src, [string]$Dst, [int]$Size)
    
    try {
        $img = [System.Drawing.Image]::FromFile($Src)
        $canvas = New-Object System.Drawing.Bitmap($Size, $Size)
        $graph = [System.Drawing.Graphics]::FromImage($canvas)
        
        $graph.CompositingQuality = [System.Drawing.Drawing2D.CompositingQuality]::HighQuality
        $graph.InterpolationMode = [System.Drawing.Drawing2D.InterpolationMode]::HighQualityBicubic
        $graph.SmoothingMode = [System.Drawing.Drawing2D.SmoothingMode]::HighQuality
        
        $graph.DrawImage($img, 0, 0, $Size, $Size)

        if ($Dst.EndsWith(".bmp", [System.StringComparison]::OrdinalIgnoreCase)) {
            $format = [System.Drawing.Imaging.ImageFormat]::Bmp
        } else {
            $format = [System.Drawing.Imaging.ImageFormat]::Png
        }

        $canvas.Save($Dst, $format)
        
        $img.Dispose(); $canvas.Dispose(); $graph.Dispose()
    }
    catch {}
}

# Backup & Apply
if (-not (Test-Path $BackupPath)) {
    New-Item -ItemType Directory -Force -Path $BackupPath | Out-Null
}

$targets = @{
    "user.png"     = 448
    "user-32.png"  = 32
    "user-40.png"  = 40
    "user-48.png"  = 48
    "user-192.png" = 192
    "user.bmp"     = 448
    "guest.png"    = 448
    "guest.bmp"    = 448
}

foreach ($name in $targets.Keys) {
    $targetFile = Join-Path $DestPath $name
    
    if (Test-Path $targetFile) {
        Copy-Item $targetFile $BackupPath -Force
    }
    
    Resize-Image -Src $TempSourcePath -Dst $targetFile -Size $targets[$name]
}

if (Test-Path $TempSourcePath) { Remove-Item $TempSourcePath }