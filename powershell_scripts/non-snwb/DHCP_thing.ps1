#remove static IP and set to DHCP

$iptype = "IPv4"
$adapter = Get-NetAdapter -name "ethernet"
$interface = $adapter | Get-NetIPInterface -AddressFamily $iptype

If ($interface.Dhcp -eq "Disabled") {
    If (($interface| Get-NetIPConfiguration).Ipv4DefaultGateway){
    }
}
$interface | Set-NetIPInterface -DHCP Enabled
$interface | Set-DnsClientServerAddress -ResetServerAddresses

