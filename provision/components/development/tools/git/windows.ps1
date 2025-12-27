Set-Package -Name Git.Git -Provider winget
$keysToRemove = @(
    "Registry::HKEY_CLASSES_ROOT\Directory\shell\git_gui",
    "Registry::HKEY_CLASSES_ROOT\Directory\shell\git_shell",
    "Registry::HKEY_CLASSES_ROOT\LibraryFolder\background\shell\git_gui",
    "Registry::HKEY_CLASSES_ROOT\LibraryFolder\background\shell\git_shell",
    "Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Classes\Directory\background\shell\git_gui",
    "Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Classes\Directory\background\shell\git_shell"
)
foreach ($key in $keysToRemove) {
    if (Test-Path -Path $key) {
        Remove-Item -Path $key -Recurse -Force -ErrorAction SilentlyContinue
    }
}