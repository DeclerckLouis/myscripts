# this script only works once (not idempotent), set all variables before running :)

# Variables
$interfaceIndex = Get-NetAdapter -Name *"Ethernet"* | Select-Object -ExpandProperty ifIndex
$ipv4 = "192.168.153.200"
$gateway = "192.168.153.1"

# Set IP address, gateway and DNS
New-NetIPAddress -InterfaceIndex $interfaceIndex -IPAddress $IPv4 -PrefixLength 24 -DefaultGateway $Gateway
Set-DnsClientServerAddress -InterfaceIndex $interfaceIndex -ServerAddresses $Gateway

# Test
Nslookup google.com
ping google.com
