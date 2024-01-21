Get-Process | select -First 5 | select -Property Name,Id,Handles | Format-Table -AutoSize
#select is een alias voor Select-Object, best vermijden om leesbaarheid te behouden

#toon het resultaat van je eerste commando in een gridview (GUI)
#Stop-Process zorgt ervoor dat de "OK" knop in de GUI de geselecteerde processen stopt
Get-Process | Out-GridView -PassThru | Stop-Process

