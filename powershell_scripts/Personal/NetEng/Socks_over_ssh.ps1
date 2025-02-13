### THIS SCRIPT IS USED TO GET AROUND SCHOOL FIREWALLS ETC. ###
# Connects to a remote server (owned by me and known as "modem") via ssh and sets up a socks proxy. 
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
        Clear-Host
        }
}
Clear-Host
Write-Host "Thank you and have a nice day!"