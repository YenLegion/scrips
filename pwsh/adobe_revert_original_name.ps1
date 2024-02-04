# Function to prompt for Yes/No confirmation
function Get-Confirmation {
	    $confirmation = Read-Host "Do you want to proceed? (Y/N)"
	        return ($confirmation -eq "Y" -or $confirmation -eq "y")
	        }

	        # Prompt for elevation
	        $scriptPath = $MyInvocation.MyCommand.Path
	        $principal = New-Object Security.Principal.WindowsPrincipal([Security.Principal.WindowsIdentity]::GetCurrent())
	        $adminRole = [Security.Principal.WindowsBuiltInRole]::Administrator
	        $isAdmin = $principal.IsInRole($adminRole)

	        if (-not $isAdmin) {
	        	    $confirmation = Get-Confirmation
	        	        if ($confirmation) {
	        	        	        Start-Process powershell -Verb RunAs -ArgumentList "-File $scriptPath"
	        	        	                exit
	        	        	                    } else {
	        	        	                    	        Write-Host "Script execution aborted."
	        	        	                    	                exit
	        	        	                    	                    }
	        	        	                    	                    }

	        	        	                    	                    # List of files to be reverted
	        	        	                    	                    $filesToRevert = @(
	        	        	                    	                    	    "C:\Program Files (x86)\Adobe\Adobe Sync\CoreSync\CoreSync.exeNO",
	        	        	                    	                    	        "C:\Program Files\Adobe\Adobe Creative Cloud Experience\CCXProcess.exeNO",
	        	        	                    	                    	            "C:\Program Files (x86)\Common Files\Adobe\Adobe Desktop Common\ADS\Adobe Desktop Service.exeNO",
	        	        	                    	                    	                "C:\Program Files\Common Files\Adobe\Creative Cloud Libraries\CCLibrary.exeNO",
	        	        	                    	                    	                    "C:\Program Files\Adobe\Acrobat DC\Acrobat\AdobeCollabSync.exeNO"
	        	        	                    	                    	                    )

	        	        	                    	                    	                    # Confirm before proceeding
	        	        	                    	                    	                    $confirmation = Get-Confirmation
	        	        	                    	                    	                    if (-not $confirmation) {
	        	        	                    	                    	                    	    Write-Host "Script execution aborted."
	        	        	                    	                    	                    	        exit
	        	        	                    	                    	                    	        }

	        	        	                    	                    	                    	        # Revert file names
	        	        	                    	                    	                    	        foreach ($file in $filesToRevert) {
	        	        	                    	                    	                    	        	    $originalName = $file -replace '\.exeNO$', '.exe'
	        	        	                    	                    	                    	        	        Write-Host "Reverting $file to $originalName"
	        	        	                    	                    	                    	        	            Rename-Item $file $originalName
	        	        	                    	                    	                    	        	            }

	        	        	                    	                    	                    	        	            Write-Host "`nFiles reverted successfully!"
	        	        	                    	                    	                    	        	            "`"
	        	        	                    	                    	                    	        }
	        	        	                    	                    	                    }
	        	        	                    	                    )
	        	        	                    }
	        	        }
	        }
}
