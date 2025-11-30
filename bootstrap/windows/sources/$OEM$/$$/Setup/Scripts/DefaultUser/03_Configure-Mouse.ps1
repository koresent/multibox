Set-RegistryConfiguration -Items @(
    [PSCustomObject]@{ Path = 'HKCU:\Control Panel\Mouse'; Name = 'MouseSpeed'; Type = 'String'; Value = '0' },
	[PSCustomObject]@{ Path = 'HKCU:\Control Panel\Mouse'; Name = 'MouseThreshold1'; Type = 'String'; Value = '0' },
	[PSCustomObject]@{ Path = 'HKCU:\Control Panel\Mouse'; Name = 'MouseThreshold2'; Type = 'String'; Value = '0' }
)

$regPath = "$env:SystemRoot\Cursors\Dot-White\replace.reg"

if (Test-Path $regPath) {
    reg import $regPath *> $null
<#
    $CSharpSig = @'
[DllImport("user32.dll", SetLastError = true)]
public static extern bool SystemParametersInfo(uint uiAction, uint uiParam, IntPtr pvParam, uint fWinIni);
'@

    $SysInfo = Add-Type -MemberDefinition $CSharpSig -Name "Win32SysInfo" -Namespace Win32Functions -PassThru

    $SPI_SETCURSORS = 0x0057
    $SPIF_SENDCHANGE = 0x02

    $result = $SysInfo::SystemParametersInfo($SPI_SETCURSORS, 0, [IntPtr]::Zero, $SPIF_SENDCHANGE)
#>
}