$timestamp = Get-Date -Format "yyyyMMdd_HHmmss"
$hostname = $env:COMPUTERNAME
$user = $env:USERNAME
$path = "\\DC1\shared\logs\$timestamp`_$hostname.txt"
$logmsg = "$(Get-Date -Format "HH:mm:ss") - $Username"

# Controleer of het logboekbestand al bestaat voor vandaag
if (Test-Path $path) {
    Add-Content -Path $path -Value $logmsg
} else {
    $logmsg | Set-Content -Path $path
}
