#show all running services
Get-Service

#show first 5 running services
Get-Service | Select-Object -First 5

#show all properties of Word and Powerpoint processes
Get-Process | Where-Object {($_.Name -eq "WINWORD") -or ($_.Name -eq "POWERPNT")} | Get-Member

#show all IPv4 addresses on localhost in table form sorted on interfaceindex
Get-NetIPAddress -AddressFamily IPv4 | Sort-Object -Property InterfaceIndex | Format-Table

#show 5 properties of your local disk in table form
Get-PSDrive | Where-Object {$_.Name -eq "C"} | Get-Member | Select-Object -Last 5