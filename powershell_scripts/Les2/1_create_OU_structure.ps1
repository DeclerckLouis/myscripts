#create OU users, OU groups and OU computers in the domain local.test
New-ADOrganizationalUnit -Name "OU=Users,DC=local,DC=test" -Path "DC=local,DC=test"
New-ADOrganizationalUnit -Name "OU=Groups,DC=local,DC=test" -Path "DC=local,DC=test"
New-ADOrganizationalUnit -Name "OU=Computers,DC=local,DC=test" -Path "DC=local,DC=test"
#OU_USERS
#OU_GROUPS
#OU_COMPUTERS


#create OU management, OU HR, OU webdevs under the OU users in the domain local.test
New-ADOrganizationalUnit -Name "OU=User,DC=local,DC=test" -Path "DC=local,DC=test"
New-ADOrganizationalUnit -Name "OU=Management,OU=Users,DC=local,DC=test" -Path "DC=local,DC=test"
New-ADOrganizationalUnit -Name "OU=HR,OU=Users,DC=local,DC=test" -Path "DC=local,DC=test"
New-ADOrganizationalUnit -Name "OU=Webdevs,OU=Users,DC=local,DC=test" -Path "DC=local,DC=test"
#OU_USERS
# |OU_MANAGEMENT
# |OU_HR
# |OU_WEBDEVS


#create the OU computers, with sub-OU servers and clients in the domain local.test
New-ADOrganizationalUnit -Name "OU=Computers,DC=local,DC=test" -Path "DC=local,DC=test"
New-ADOrganizationalUnit -Name "OU=Servers,OU=Computers,DC=local,DC=test" -Path "DC=local,DC=test"
New-ADOrganizationalUnit -Name "OU=Clients,OU=Computers,DC=local,DC=test" -Path "DC=local,DC=test"
#OU_COMPUTERS
# |OU_SERVERS
# |OU_CLIENTS

