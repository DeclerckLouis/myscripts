# A script that takes the output of the Get-EventLog cmdlet and writes it to a csv file.
write-host "Initializing..."

### Variables ###
# Path to the directory where the event log files will be saved
$Eventlog_dir_path = "C:\Windows\Temp\LogCollection"
write-host "Log directory path: $Eventlog_dir_path"

# Paths to the csv files where the event log data will be saved
$Eventlog_paths = @{
    "Security"    = "$Eventlog_dir_path\eventlog_Security.csv"
    "System"      = "$Eventlog_dir_path\eventlog_system.csv"
    "Application" = "$Eventlog_dir_path\eventlog_application.csv"
    "OAlerts"     = "$Eventlog_dir_path\eventlog_OAlerts.csv"
}

### Functions ###
# Function to check if the script is running with administrative privileges
function Check_Admin {
    $currentUser = New-Object Security.Principal.WindowsPrincipal([Security.Principal.WindowsIdentity]::GetCurrent())
    return $currentUser.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
}

# Function to get event log and export to csv
function Export-EventLogToCsv {
    param (
        [string]$LogName,
        [string]$FilePath
    )
    $Eventlog = Get-EventLog -LogName $LogName -Newest 10000
    $Eventlog | Export-Csv -Path $FilePath -NoTypeInformation
}

### Check ###
# Relaunch the script with elevated privileges if not running as admin
if (-not (Check_Admin)) {
    Start-Process powershell -ArgumentList "-File `"$PSCommandPath`"" -Verb RunAs
    exit
}


### Main ###
# Check if log directory exists, if not create it
if (-not (Test-Path $Eventlog_dir_path)) {
    write-host "Creating directory $Eventlog_dir_path."
    New-Item -ItemType Directory -Path $Eventlog_dir_path
}

# Export event logs to csv files (an attempt to parallelize the process)
Write-Host "Exporting event logs to csv files..."
$jobs = @()
foreach ($log in $Eventlog_paths.Keys) {
    $jobs += Start-Job -ScriptBlock {
        param ($logName, $filePath)
        Import-Module -Name Microsoft.PowerShell.Management
        Get-EventLog -LogName $logName -Newest 10000 | Export-Csv -Path $filePath -NoTypeInformation
        write-host "Finished with $logName."
    } -ArgumentList $log, $Eventlog_paths[$log]
}

# Wait for all jobs to complete
$jobs | ForEach-Object { 
    $_ | Wait-Job | Out-Null
    $_ | Receive-Job | Out-Null
    $_ | Remove-Job 
}
write-host "Event logs exported to csv files in $Eventlog_dir_path."
write-host "Have a nice day!"