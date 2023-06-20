# Check if running as administrator
$isAdmin = ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)

# If not running as administrator, restart script with elevated privileges
if (-not $isAdmin) {
	# Start a new process with elevated privileges
	Start-Process powershell.exe -Verb RunAs -ArgumentList "-File `"$PSCommandPath`""

	# Exit the current script
	exit
}
$services = @("Audio*"#, "Service2", "Service3")  # Replace with your desired service names

# Check the status of the services
$serviceStatus = Get-Service -Name $services

# Display the current status of the services
$serviceStatus | Format-Table Name, Status

# Prompt for user input
$choice = Read-Host "Do you want to restart or stop the services? (R)estart / (S)top / (N)o"

# Process user choice
switch ($choice.ToUpper()) {
	"R" {
		# Restart services
		$services | ForEach-Object {
			Restart-Service -Name $_ -ErrorAction SilentlyContinue
		}
		Write-Host "Services restarted."
		break
	}
	"S" {
		# Stop services
		$services | ForEach-Object {
			Stop-Service -Name $_ -ErrorAction SilentlyContinue
		}
		Write-Host "Services stopped."
		break
	}
	"N" {
		Write-Host "No action taken."
		break
	}
	default {
		Write-Host "Invalid choice."
		break
	}
}
	    	                	                                            	                	                                            	                        	                    
}
}
}
}
}
}
}
	                    