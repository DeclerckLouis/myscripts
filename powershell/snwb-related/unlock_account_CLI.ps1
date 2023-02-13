#This script is what i used in SimLab1 to unlock accounts. It will be edited in the near future to use a GUI to select the account to unlock, instead of typing it in the console.
#
##This script requires ‘RSAT: Active Directory Domain Services and Lightweight Directory Services Tools‘ in order to work.


Add-WindowsFeature RSAT-AD-Powershell
Import-module ActiveDirectory
cls

#alle locked accounts opvragen + name en samaccountname afprinten
write-Host "Alle locked accounts: "
$lockedaccounts = Search-ADAccount -LockedOut | Select name,samaccountname
$lockedaccounts
write-Host "Einde locked accounts. (Indien hier niks staat, dan zijn er geen locked accounts.)"
write-Host ""

#één account unlocken, of niks unlocken.
$yesorno = read-Host "Wilt u een account unlocken? (ja/nee)"

while (1 -eq 1){
    if($yesorno -eq "ja"){
        $samaccountname = Read-Host "Geef een gebruikersnaam op om te unlocken"
        Unlock-ADAccount $samaccountname
        $yesorno = read-Host "Wilt u een account unlocken? (ja/nee)"
    }
    elseif($yesorno -eq "nee"){
        break
        #exit
    }
}

