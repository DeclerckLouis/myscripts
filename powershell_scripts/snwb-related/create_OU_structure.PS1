# Import the Active Directory module
Import-Module ActiveDirectory

#Set Domain name
$baseDN = "DC=DLLOCAL,DC=TEST"

# DC naam
$domainController = "DC1.DLLOCAL.TEST"

# Locations list
$locations = @("BRUGGE", "KORTRIJK", "SERVERS")

# Sub-OU list per locatie
$subOUs = @("ADMIN", "COMPUTERS", "DEPARTMENTS", "GROUPS")

# Sub-list voor Departments
$departmentSubOUs = @("FINANCE", "IT", "LEGAL", "MARKETING", "SALES")

# overcomplicated For-loop
foreach ($location in $locations) {
    $locationDN = "OU=$location,$baseDN"
    Write-Host "Creating location OU: $locationDN"
    #Protected from accidental deletion false because i had to try this a LOT of times :)
    New-ADOrganizationalUnit -Name $location -Path $baseDN -Server $domainController -ProtectedFromAccidentalDeletion $false
    if($location -ne "Servers"){
        foreach ($subOU in $subOUs) {
            $subOUDN = "OU=$subOU,$locationDN"
            Write-Host "Creating sub-OU: $subOUDN"
            New-ADOrganizationalUnit -Name $subOU -Path $locationDN -Server $domainController -ProtectedFromAccidentalDeletion $false
            if ($subOU -eq "Departments") {
                foreach ($department in $departmentSubOUs) {
                    $departmentDN = "OU=$department,$subOUDN"
                    Write-Host "Creating department sub-OU: $departmentDN"
                    New-ADOrganizationalUnit -Name $department -Path $subOUDN -Server $domainController -ProtectedFromAccidentalDeletion $false
                }
            }
        }
    }
}
