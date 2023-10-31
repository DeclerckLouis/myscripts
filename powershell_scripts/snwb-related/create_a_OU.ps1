# Import the Active Directory module
Import-Module ActiveDirectory

#Set Domain name
$baseDN = "DC=DLLOCAL,DC=TEST"
cls

# Get new OU name
$newOU = Read-Host "Geef naam van nieuwe OU op: "

# Create new OU
New-ADOrganizationalUnit -name $newOU -Path $baseDN

# Get new OU item and print it out
$ou = (Get-ADOrganizationalUnit -Filter 'Name -like $newOU').ObjectGUID
Write-Host "GUID van de aangemaakte OU is:$ou"

# Double check if wanted
# Get-ADOrganizationalUnit -Filter 'ObjectGUID -eq $ou' | Format-Table Name,ObjectGUID,DistinguishedName 