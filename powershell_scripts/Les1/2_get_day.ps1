#QUIZ
#Get todays date

$todaydate = Get-Date
write-host "Vandaag is het $todaydate"

#get info about disk space
Get-Disk | Get-Partition | Get-Volume | Select-Object FileSystem,Size,FreeSpace,SizeRemaining

#get all cmdlets with the word "service" in it
Get-Command -Name *service*

##################################################################################################
#more advanced, get today's day and translate it to dutch

$today = (Get-Date).DayOfWeek

switch($today){
"monday" {write-host "Maandag"}
"tuesday" {write-host "Dinsdag"}
"wednesday" {write-host "Woensdag"}
"thursday" {write-host "Donderdag"}
"friday" {write-host "Vrijdag"}
"saturday" {write-host "Zaterdag"}
"sunday" {write-host "Zondag"}
}


