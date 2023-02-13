#add computers from excel to AD
$computers = import-xlsx -path "C:\Users\user\Desktop\computers.xlsx" -worksheetname "computers"
foreach ($computer in $computers){
    New-Adcomputer -Name $computer.computername -SamAccountName $computer.computername -Path "OU=Computers,OU=SNWB,DC=
}
    