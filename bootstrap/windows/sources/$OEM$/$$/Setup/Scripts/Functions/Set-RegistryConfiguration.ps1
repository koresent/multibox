function Set-RegistryConfiguration {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true, ValueFromPipeline = $true)]
        [PSCustomObject[]]$Items
    )

    process {
        foreach ($item in $Items) {

            if (!(Test-Path -Path $item.Path)) {
                New-Item -Path $item.Path -Force -ErrorAction Stop | Out-Null
            }

            if ($null -ne $item.Name) {
                New-ItemProperty -Path $item.Path -Name $item.Name -PropertyType $item.Type -Value $item.Value -Force -ErrorAction Stop | Out-Null
            }
            else {
                Set-Item -Path $item.Path -Value $item.Value -Force -ErrorAction Stop | Out-Null
            }
        }
    }
}