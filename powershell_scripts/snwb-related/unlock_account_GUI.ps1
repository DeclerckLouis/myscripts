#This script works the same as -> Get-Process | Out-GridView -PassThru | Stop-Process
#this script requires RSAT: Active Directory Domain Services and Lightweight Directory Services Tools, or just all RSAT tools.
Get-WindowsCapability -Name RSAT* -Online
Add-WindowsCapability -Name rsat.ActiveDirectory* -Online


Import-module ActiveDirectory

write-Host "Alle locked accounts: "
$lockedaccounts = Search-ADAccount -LockedOut | Select-Object name,samaccountname
Write-Host "$lockedaccounts"
Search-ADAccount -LockedOut | Out-GridView -Title "Unlock Active Directory Accounts" -Wait -PassThru | Unlock-ADAccount

