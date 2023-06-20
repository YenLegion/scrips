
$services = @("Service1", "Service2", "Service3")  # Replace with your desired service names

# Check the status of the services
$serviceStatus = Get-Service -Name $services

# Display the current status of the services
$serviceStatus | Format-Table Name, Status#$ want to restart or stop the services? (R)estart / (S)top / (N)o"#s{-Object { -Name $_ -ErrorAction SilentlyContinues restarted."-Object {ame $_ -ErrorAction SilentlyContinues stopped."on taken." choice."