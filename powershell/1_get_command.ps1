#cmdlet om andere cmdlets te vinden
Get-Command

#cmdlet om andere cmdlets te vinden met GET- als prefix
Get-Command -Name Get-*
Get-Command -verb get

#cmdlet om andere cmdlets te vinden met -Service als suffix
Get-Command -Name *-Service
Get-Command -noun Service

#gebruiken van jokertekens
Get-Command *firewall*
Get-Command *proces*

#get-member - detailinformatie omtrent een object
Get-Process | Get-Member


#read en write info op cli MET variabelen
$naam = Read-Host "Wat is je naam?"
Write-Host "Hallo $naam"
