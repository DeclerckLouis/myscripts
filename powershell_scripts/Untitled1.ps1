#1.
switch($today){
"monday" {write-host "Maandag"}
"tuesday" {write-host "Dinsdag"}
"wednesday" {write-host "Woensdag"}
"thursday" {write-host "Donderdag"}
"friday" {write-host "Vrijdag"}
"saturday" {write-host "Zaterdag"}
"sunday" {write-host "Zondag"}
}



#1.
#foreach item in list
$list = 100,200,300,400
#write-host($list)
foreach($i in $list){
    Write-Host($i)
}



#2.
foreach($i in 1..100){
    write-host($i)
}



#3.
Get-Disk | foreach { write-host($_.SerialNumber) }
#kan ook
ForEach ($disk in Get-Disk){
    write-Host($disk)
}
Get-Disk | Get-Member
Get-Disk | select-object  SerialNumber



#4.
Get-Partition | foreach { write-host($_.Size) }



#5.
#neen
$location = "C:\Users\decle\Downloads"
Get-ChildItem $location | foreach {Write-Host($_.Length)}


