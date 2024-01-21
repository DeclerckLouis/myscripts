#This script shows all disabled accounts and then prompts the user if they want to re-enable one of the accounts.
#it's not very good but does the job.

#alle Disabled accounts opvragen + name en samaccountname afprinten
write-Host "Alle disabled accounts: "
$disableddaccounts = Search-ADAccount -AccountDisabled| Select-Object name,samaccountname
$diabledaccounts
write-Host "Einde disabled accounts. (Indien hier niks staat, dan zijn er geen disabled accounts.)"
write-Host ""

#één account unlocken, of niks unlocken.
$yesorno = read-Host "Wilt u een account re-enablen? (ja/nee)"

while (1 -eq 1){
    if($yesorno -eq "ja"){
        $samaccountname = Read-Host "Geef een gebruikersnaam op om te re-enablen"
        Enable-ADAccount $samaccountname
        $yesorno = read-Host "Wilt u nog een account unlocken? (ja/nee)"
    }
    elseif($yesorno -eq "nee"){
        break
        #exit
    }
}
