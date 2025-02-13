# setup internet connection
# update help
# install ÂD components



#exit SConfig first, then exectute the following commands:

hostname
ipconfig /all

#set hostname
Rename-Computer -NewName "WS2-2022-core" -Restart
#Rename-Computer "WS2-2022-core" -Restart
#kan ook met HOSTNAME.EXE maar doen we niet want is geen powershell commando

#set IP address
$interfaceIndex = Get-NetAdapter -Name *"Ethernet"* | Select-Object -ExpandProperty ifIndex
$ipv4 = "192.168.153.200"
$gateway = "192.168.153.1"
New-NetIPAddress -InterfaceIndex $interfaceIndex -IPAddress $IPv4 -PrefixLength 24 -DefaultGateway $Gateway
Set-DnsClientServerAddress -InterfaceIndex $interfaceIndex -ServerAddresses $Gateway
ping google.com

#check ip address
ipconfig /all

#update help
Update-Help

#install AD features
Install-WindowsFeature -Name AD-Domain-Services -IncludeManagementTools

#install AD forest
install-ADDSForest -DomainName "local.test" -DomainNetbiosName "local" -SafeModeAdministratorPassword (ConvertTo-SecureString -AsPlainText "Test123" -Force) -Force:$true




