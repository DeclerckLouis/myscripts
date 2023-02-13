#1.2 en 1.3
$connection = (Test-Connection -ComputerName google.com)
if ($connection -notcontains $Error){
    Write-Host "Bereikbaar!"
}
else {
    Write-Host "Onbereikbaar!"
}

if ($connection.StatusCode -eq "0"){
    Write-Host "Bereikbaar!"
}
else {
    Write-Host "Onbereikbaar"
}
