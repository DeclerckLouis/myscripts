#This script shows all disabled accounts and then prompts the user if they want to re-enable one of the accounts.
#it's not very good but does the job.

#alle Disabled accounts opvragen + name en samaccountname afprinten
write-Host "Alle disabled accounts: "
$disableddaccounts = Search-ADAccount -AccountDisabled| Select-Object name,samaccountname
$diabledaccounts
write-Host "Einde disabled accounts. (Indien hier niks staat, dan zijn er geen disabled accounts.)"
write-Host ""
