#not for production use
# a workaround for the issue with the static IP address not being set on the first boot

$IPv4 = "192.168.0.171"
$Gateway = "192.168.0.1"
New-NetIPAddress -InterfaceAlias "Ethernet" -IPAddress $IPv4 -PrefixLength 24 -DefaultGateway $Gateway
Set-DnsClientServerAddress -InterfaceAlias "Ethernet" -ServerAddresses $Gateway