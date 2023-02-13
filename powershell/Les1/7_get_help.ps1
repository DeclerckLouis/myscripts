# learn how to work with help in powershell (get-help)
#de syntax van get-help is als volgt:
#Get-Help <commando> -<parameter> <waarde>

Get-help Get-Help # geeft de help van get-help weer


#wanneer in de sytax van een cmdlet een bepaalde parameter tussen [] staat, dan is die optioneel
#in dit geval is de parameter -Full optioneel, dus je kan ook gewoon Get-Help Start-Service doen 
Get-Help Start-Service -Full # geeft alle properties van een proces weer 
Get-Help Start-Service -Full | Format-List # geeft alle properties van een proces weer in een lijst
Get-Help Start-Service -Full | Format-Table # geeft alle properties van een proces weer in een tabel
Get-Help Start-Service -Full | Format-Table -AutoSize # geeft alle properties van een proces weer in een tabel met automatische breedte
Get-Help Start-Service -Full | Format-Table -AutoSize -Property Name,DisplayName # geeft alle properties van een proces weer in een tabel met automatische breedte, en toont enkel de properties Name en DisplayName

Get-Help Start-Service -Description # geeft de description van start-service weer
Get-Help Start-Service -Detailed # geeft de detailed description van start-service weer
Get-Help Start-Service -Syntax # geeft de syntax van start-service weer
Get-Help Start-Service -Examples # geeft de examples van start-service weer (als die er zijn)
Get-Help Start-Service -Online # geeft de online help van start-service weer
Get-Help Start-Service -ShowWindow # geeft de online help van start-service weer in een apart venster
Get-Help Start-Service -Parameter *Name* # geeft de parameters van start-service weer die Name bevatten (in dit geval is dat de enige parameter)
Get-Help Start-Service -Parameter * -Full # geeft alle parameters van start-service weer met hun properties


#start een enkele service
Start-Service -DisplayName "calculator" # start de calculator service

#start meerdere services
Start-Service -DisplayName "calculator","Windows Update","Windows Time" # start de calculator service, windows update en windows time

#kan ook door alle services in een variabele steken
$services = "calculator","Windows Update","Windows Time"
Start-Service -DisplayName $services