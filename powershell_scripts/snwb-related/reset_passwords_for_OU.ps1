Import-Module ActiveDirectory
# Always import the ActiveDirectory module first

# This script will reset the password for all users in the OU specified in the SearchBase parameter (in this case SALES)
# Used hard coded values for locations as it didn't seem to work with wildcards
$locations = @("BRUGGE", "KORTRIJK")
foreach ($loc in $locations) {
# get $user variable
$user = Get-ADUser -Filter * -SearchBase "OU=SALES,OU=DEPARTMENTS,OU=$loc,DC=DLLOCAL,DC=test"
# set password, passthru, require change of password, and enable account
Set-ADAccountPassword -Identity $user -Reset -NewPassword (ConvertTo-SecureString -AsPlainText "Test123" -Force) -PassThru | Set-ADUser -ChangePasswordAtLogon $true -PassThru |Enable-ADaccount $user
}
