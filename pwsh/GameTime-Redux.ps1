# Find all matching processes.
$targetApplications = @(
    "Caprine",
    "msedge",
    "Logi*",
    "onenoteim",
    "ModernFlyoutsHost",
    "Powertoys",
    "wfcs",
    "OfficeClickToRun",
    "OpenRGB",
    "dopus",
    "Twinkle Tray",
    "wfc",
    "DefenderUI"
    )
$processes = Get-Process | Where-Object { $targetApplications -contains $_.ProcessName }

# If no matching processes are found, display a message and exit.
if ($processes.Count -eq 0) {
    Write-Host "No matching applications are currently running."
    return
}

# Display a list of all matching processes.
Write-Host "Matching applications found:"
foreach ($process in $processes) {
    Write-Host "  $($process.Name) [$($process.Id)] - $($process.MainWindowTitle)"
}

# Prompt for confirmation.
$confirmation = Read-Host "Do you want to close all matching applications? (Y/N)"
if ($confirmation.ToUpper() -ne "Y") {
    Write-Host "Closing operation cancelled."
    return
}

# Close all matching processes.
$processes | ForEach-Object {
    Write-Host "Closing process $($_.Name) [$($_.Id)]..."
    try {
        $_ | Stop-Process -Force -ErrorAction Stop
    } catch {
        Write-Host "Failed to close process: $_"
    }
}
Write-Host "All matching applications closed."



