# Kill the Windows Explorer process
taskkill /f /im explorer.exe

# Start the Windows Explorer process
start explorer.exe

# Wait for the Windows Explorer process to start
timeout /t 5 >nul

# Check if the Windows Explorer process is running
tasklist | find /i "explorer.exe" >nul && (

    echo Windows Explorer restarted successfully

) || (
echo Failed to restart Windows Explorer)

# Pause the script

pause