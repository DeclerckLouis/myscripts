#on the DC "local.test" create a new OU structure, with the following structure: 
#BERLIN
# |ADMIN
# |COMPUTERS
# |DEPARTMENTS
# | |FINANCE
# | |IT
# | |LEGAL
# | |MARKETING
# | |SALES
# |GROUPS
#BRUGES
# |ADMIN
# |COMPUTERS
# |DEPARTMENTS
# | |FINANCE
# | |IT
# | |LEGAL
# | |MARKETING
# | |SALES
# |GROUPS

#For berlin
New-ADOrganizationalUnit -Name "OU=BERLIN,DC=local,DC=test" -Path "DC=local,DC=test"
New-ADOrganizationalUnit -Name "OU=ADMIN,OU=BERLIN,DC=local,DC=test" -Path "DC=local,DC=test"
New-ADOrganizationalUnit -Name "OU=COMPUTERS,OU=BERLIN,DC=local,DC=test" -Path "DC=local,DC=test"
New-ADOrganizationalUnit -Name "OU=DEPARTMENTS,OU=BERLIN,DC=local,DC=test" -Path "DC=local,DC=test"
New-ADOrganizationalUnit -Name "OU=FINANCE,OU=DEPARTMENTS,OU=BERLIN,DC=local,DC=test" -Path "DC=local,DC=test"
New-ADOrganizationalUnit -Name "OU=IT,OU=DEPARTMENTS,OU=BERLIN,DC=local,DC=test" -Path "DC=local,DC=test"
New-ADOrganizationalUnit -Name "OU=LEGAL,OU=DEPARTMENTS,OU=BERLIN,DC=local,DC=test" -Path "DC=local,DC=test"
New-ADOrganizationalUnit -Name "OU=MARKETING,OU=DEPARTMENTS,OU=BERLIN,DC=local,DC=test" -Path "DC=local,DC=test"
New-ADOrganizationalUnit -Name "OU=SALES,OU=DEPARTMENTS,OU=BERLIN,DC=local,DC=test" -Path "DC=local,DC=test"
New-ADOrganizationalUnit -Name "OU=GROUPS,OU=BERLIN,DC=local,DC=test" -Path "DC=local,DC=test"

#For bruges
New-ADOrganisationalUnit -Name "OU=BRUGES,DC=local,DC=test" -Path "DC=local,DC=test"
New-ADOrganisationalUnit -Name "OU=ADMIN,OU=BRUGES,DC=local,DC=test" -Path "DC=local,DC=test"
New-ADOrganisationalUnit -Name "OU=COMPUTERS,OU=BRUGES,DC=local,DC=test" -Path "DC=local,DC=test"
New-ADOrganisationalUnit -Name "OU=DEPARTMENTS,OU=BRUGES,DC=local,DC=test" -Path "DC=local,DC=test"
New-ADOrganisationalUnit -Name "OU=FINANCE,OU=DEPARTMENTS,OU=BRUGES,DC=local,DC=test" -Path "DC=local,DC=test"
New-ADOrganisationalUnit -Name "OU=IT,OU=DEPARTMENTS,OU=BRUGES,DC=local,DC=test" -Path "DC=local,DC=test"
New-ADOrganisationalUnit -Name "OU=LEGAL,OU=DEPARTMENTS,OU=BRUGES,DC=local,DC=test" -Path "DC=local,DC=test"
New-ADOrganisationalUnit -Name "OU=MARKETING,OU=DEPARTMENTS,OU=BRUGES,DC=local,DC=test" -Path "DC=local,DC=test"
New-ADOrganisationalUnit -Name "OU=SALES,OU=DEPARTMENTS,OU=BRUGES,DC=local,DC=test" -Path "DC=local,DC=test"
New-ADOrganisationalUnit -Name "OU=GROUPS,OU=BRUGES,DC=local,DC=test" -Path "DC=local,DC=test"
