$id   = [System.Security.Principal.NTAccount]"Administrators"
$rule = New-Object System.Security.AccessControl.RegistryAccessRule($id, "FullControl", 3, 0, 0)
$paths = "SOFTWARE\Classes\DesktopBackground\Shell\Personalize", "SOFTWARE\Classes\DesktopBackground\Shell\Display"

foreach ($p in $paths) {
    $root = [Microsoft.Win32.Registry]::LocalMachine
    if (-not ($sub = $root.OpenSubKey($p))) { continue }
    $sub.Close()

    $items = @("$p") + (Get-ChildItem "HKLM:\$p" -Recurse).Name -replace "HKEY_LOCAL_MACHINE\\", ""
    
    foreach ($path in $items) {
        try {
            $key = $root.OpenSubKey($path, [Microsoft.Win32.RegistryKeyPermissionCheck]::ReadWriteSubTree, [System.Security.AccessControl.RegistryRights]::TakeOwnership)
            if ($key) {
                $acl = $key.GetAccessControl(); $acl.SetOwner($id); $key.SetAccessControl($acl); $key.Close()
            }
            $key = $root.OpenSubKey($path, [Microsoft.Win32.RegistryKeyPermissionCheck]::ReadWriteSubTree, [System.Security.AccessControl.RegistryRights]::ChangePermissions)
            if ($key) {
                $acl = $key.GetAccessControl(); $acl.AddAccessRule($rule); $key.SetAccessControl($acl); $key.Close()
            }
        } catch { }
    }
}

$targetFolder = Join-Path $PSScriptRoot "..\..\Resources\ContextMenu"
$targetFolder = [System.IO.Path]::GetFullPath($targetFolder)

if (!(Test-Path $targetFolder)) {
    Write-Log "Target folder not found!" "ERROR"
    exit 1
}

$regFiles = Get-ChildItem -Path $targetFolder -Filter "*.reg" -File

if ($regFiles.Count -eq 0) {
    Write-Log "No .reg files found in target folder." "WARN"
}

foreach ($reg in $regFiles) {
    & reg.exe import "$($reg.FullName)" *>$null

    if ($LASTEXITCODE -ne 0) {
        Write-Log "Failed to import $($reg.Name). ExitCode: $LASTEXITCODE" "ERROR"
    }
}