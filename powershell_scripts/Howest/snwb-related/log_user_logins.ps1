# Get date and time in right format

# MM for month, mm for minutes
$date = Get-Date -Format yyyyMMdd
$time = Get-Date -Format hh:mm:ss

# Hostname and username
$computerName = hostname
$user = whoami

# Put it in the log
# contents | Out-File -FilePath file -Append
"$time - $user" | Out-File -FilePath \\DC1\logging\$Date$ComputerName.txt -Append 

##############################################################################################



########## OBSOLETE ##########

# $timestamp = Get-Date -Format "yyyyMMdd_HHmmss"
# $hostname = $env:COMPUTERNAME
# $user = $env:USERNAME
# $path = "\\DC1\shared\logs\$timestamp`_$hostname.txt"
# $logmsg = "$(Get-Date -Format "HH:mm:ss") - $Username"

# # Check if file exists, if so append, if not create and write (unnecessary, out-file -append does this automatically)
# if (Test-Path $path) {
#     Add-Content -Path $path -Value $logmsg
# } else {
#     $logmsg | Set-Content -Path $path
# }
