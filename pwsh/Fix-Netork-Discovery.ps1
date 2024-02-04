# Function to restart a service
function Restart-Service($serviceName) {
    $service = Get-Service -Name $serviceName -ErrorAction SilentlyContinue

    if ($service -ne $null) {
        Write-Host "Restarting service: $serviceName"
        Restart-Service -Name $serviceName
    } else {
        Write-Host "Service not found: $serviceName"
    }
}

# List of services to restart
$servicesToRestart = @(
    "Dnscache",                 # DNS Client
    "FDResPub",                 # Function Discovery Resource Publication
    "SSDPSRV",                  # SSDP Discovery
#   "upnphost",                 # UPnP Device Host
    "lltdsvc"                   # Link-Layer Topology Mapper
)

# Restart each service in the list
foreach ($service in $servicesToRestart) {
    Restart-Service $service
}

Write-Host "Services restarted successfully."
