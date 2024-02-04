@echo off
setlocal enabledelayedexpansion

:: Check for administrative privileges
net session >nul 2>&1
if %errorLevel% neq 0 (
	    echo "This script requires administrative privileges. Please run as an administrator."
	        echo Exiting script. No changes made.
	            exit /b 1
	            )

	            echo "This script will release and renew your IP configuration, clear ARP cache, refresh NetBIOS names, flush DNS, and register DNS."

	            set /p confirm="Do you want to proceed? (Y/N): "
	            if /i "!confirm!" neq "Y" (
	            	    echo Exiting script. No changes made.
	            	        exit /b 1
	            	        )

	            	        :: Elevate script to run with administrative privileges
	            	        >nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system" && (
	            	        	    goto :runScript
	            	        	    ) || (
	            	        	    	    echo Requesting administrative privileges...
	            	        	    	        if exist "%temp%\getadmin.vbs" del "%temp%\getadmin.vbs"
	            	        	    	            echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
	            	        	    	                echo UAC.ShellExecute "!batchPath!", "", "", "runas", 1 >> "%temp%\getadmin.vbs"
	            	        	    	                    "%temp%\getadmin.vbs"
	            	        	    	                        del "%temp%\getadmin.vbs"
	            	        	    	                            exit /b
	            	        	    	                            )

	            	        	    	                            :runScript

	            	        	    	                            echo Releasing IP configuration...
	            	        	    	                            ipconfig /release

	            	        	    	                            echo Renewing IP configuration...
	            	        	    	                            ipconfig /renew

	            	        	    	                            echo Clearing ARP cache...
	            	        	    	                            arp -d *

	            	        	    	                            echo Refreshing NetBIOS names...
	            	        	    	                            nbtstat -R
	            	        	    	                            nbtstat -RR

	            	        	    	                            echo Flushing DNS...
	            	        	    	                            ipconfig /flushdns

	            	        	    	                            echo Registering DNS...
	            	        	    	                            ipconfig /registerdns

	            	        	    	                            echo Script completed successfully.
	            	        	    	                            
	            	        	    )
	            	        )
	            )
)
