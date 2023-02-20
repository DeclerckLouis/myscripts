#get DN of a user
$User = Get-ADUser -Identity "user1" -Properties DistinguishedName
write_host $User.DistinguishedName

#get DN of a group
$Group = Get-ADGroup -Identity "group1" -Properties DistinguishedName
write_host $Group.DistinguishedName

#add user to group
Add-ADGroupMember -Identity "group1" -Members "user1"

#remove user from group
Remove-ADGroupMember -Identity "group1" -Members "user1"



#get DN of configuration NC
$NC = Get-ADDomainController -Identity "WS2_2022_core" -Properties ConfigurationNamingContext
write_host $NC.ConfigurationNamingContext

#get DN of schema NC
$NC = Get-ADDomainController -Identity "WS2_2022_core" -Properties SchemaNamingContext
write_host $NC.SchemaNamingContext

#get DN of default NC
$NC = Get-ADDomainController -Identity "WS2_2022_core" -Properties DefaultNamingContext

#create a AD user with password and OU "TEST"
New-ADUser -Name "Bob The Builder" -GivenName "Bob" -Surname "The Builder" -SamAccountName "bob.tb" -Path "OU=test,DC=local,DC=test" -AccountPassword(Read-Host -AsSecureString "Input Password") -PasswordNeverExpires $true -Enabled $true


