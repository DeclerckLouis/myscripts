#add computers from excel to AD
$computers = import-xlsx -path "C:\Users\user\Desktop\computers.xlsx" -worksheetname "computers"
foreach ($computer in $computers){
    New-Adcomputer 
    -Name $computer.computername 
    -SamAccountName $computer.computername 
    -Path "OUComputers,DC=snwb,DC=local" 
    -Enabled $true 
    -Description $computer.description 
    -OperatingSystem $computer.operatingsystem 
    -OperatingSystemVersion $computer.operatingsystemversion 
    -OperatingSystemServicePack $computer.operatingsystemservicepack 
    -UserPrincipalName $computer.userprincipalname 
    -ServicePrincipalName $computer.serviceprincipalname 
    -DnsHostName $computer.dnshostname 
    -Credential $credential
}