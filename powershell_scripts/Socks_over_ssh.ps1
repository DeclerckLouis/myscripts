### THIS SCRIPT IS USED TO GET AROUND SCHOOL FIREWALLS ETC. ###
# Connects to a remote server (owned by me and known as "modem") via ssh and sets up a socks proxy.
<#
.Synopsis
    Modify proxy settings for the current user.
 
.DESCRIPTION
    Modify proxy settings for the current user modifying the windows registry.
 
.EXAMPLE
    Get the proxy settings for the current user
 
    PS D:\> get-proxy
    ProxyServer ProxyEnable
    ----------- -----------
                        0
 
.EXAMPLE
   Set the proxy server for the current user. Test the address and if the TCP Port is open before applying the settings.
   proxy squid.server.com 3128    # or   set-proxy -server "yourproxy.server.com" -port 3128
  
.EXAMPLE
   Remove the current proxy settings for the user.
 
.NOTES
   Heavely based on the work of Paolo Frigo, https://www.scriptinglibrary.com
#>
 
function Get-Proxy (){
    Get-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Internet Settings' | Select-Object ProxyServer, ProxyEnable        
}
 
function Set-Proxy { 
    [CmdletBinding()]
    [Alias('proxy')]
    [OutputType([string])]
    Param
    (
        # server address
        [Parameter(Mandatory = $true,
            ValueFromPipelineByPropertyName = $true,
            Position = 0)]
        $Server,
        # port number
        [Parameter(Mandatory = $true,
            ValueFromPipelineByPropertyName = $true,
            Position = 1)]
        $Port    
    )
    #Test if the TCP Port on the server is open before applying the settings
    If ((Test-NetConnection -ComputerName $Server -Port $Port).TcpTestSucceeded) {
        Set-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Internet Settings' -name ProxyServer -Value "socks=$($Server):$($Port)"
        Set-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Internet Settings' -name ProxyEnable -Value 1
        Get-Proxy #Show the configuration 
    }
    Else {
        Write-Error -Message "The proxy address is not valid:  $($Server):$($Port)"
    }    
}
 
function Remove-Proxy (){    
    Set-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Internet Settings' -name ProxyServer -Value ""
    Set-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Internet Settings' -name ProxyEnable -Value 0
}



#start proxy over ssh
$Socksport = 1337
$proc = Start-Process -NoNewWindow -FilePath ssh.exe -ArgumentList "-D $Socksport -f -C -q -N modem" -PassThru -Verbose

Set-Proxy -Server "localhost" -Port $Socksport

while ($proc.HasExited -eq $false) {
    # Ask to stop the proxy connection
    $close = Read-Host "To stop proxy, press enter."
    if ($close -contains ""){
        $proc.CloseMainWindow($true)
        $proc | Stop-Process
        Remove-Proxy
        cls
        }
}
cls
Write-Host "Thank you and have a nice day!"