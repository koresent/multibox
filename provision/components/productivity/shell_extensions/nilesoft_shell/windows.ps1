Set-Package -Name Nilesoft.Shell -Provider winget
Set-Config -Source "files\shell.nss" -Destination "$env:ProgramFiles\Nilesoft Shell\shell.nss"
Set-Config -Source "files\peazip.ico" -Destination "$env:ProgramFiles\Nilesoft Shell\imports\peazip.ico"
Set-Config -Source "files\winmerge.ico" -Destination "$env:ProgramFiles\Nilesoft Shell\imports\winmerge.ico"