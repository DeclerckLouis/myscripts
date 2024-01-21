#get DN of a user
$User = Get-ADUser -Identity "bob" -Properties DistinguishedName
write_host $User.DistinguishedName

#get DN of a group
$Group = Get-ADGroup -Identity "users" -Properties DistinguishedName
write_host $Group.DistinguishedName

#add user to group
Add-ADGroupMember -Identity "group1" -Members "bob"

#remove user from group
Remove-ADGroupMember -Identity "group1" -Members "bob"



#get DN of configuration NC
$NC = Get-ADDomainController -Identity "WS2_2022_core" -Properties ConfigurationNamingContext
write_host $NC.ConfigurationNamingContext

#get DN of schema NC
$NC = Get-ADDomainController -Identity "WS2_2022_core" -Properties SchemaNamingContext
write_host $NC.SchemaNamingContext

#get DN of default NC
$NC = Get-ADDomainController -Identity "WS2_2022_core" -Properties DefaultNamingContext

#create a AD user with password and OU "TEST"
$OU = Get-ADOrganizationalUnit -Identity "OU=test,DC=local,DC=test" -Properties DistinguishedName
write_host $OU
New-ADUser -Name "bob" -DisplayName "Bob The builder" -Accountpassword (ConvertTo-SecureString -AsPlainText "Test123" -Force) -Path $OU




#create OU test
New-ADOrganizationalUnit -Name "OU=test,DC=local,DC=test" -Path "DC=local,DC=test"

