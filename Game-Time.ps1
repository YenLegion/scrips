# Self-elevate the script if required
if (-Not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] 'Administrator')) {
 if ([int](Get-CimInstance -Class Win32_OperatingSystem | Select-Object -ExpandProperty BuildNumber) -ge 6000) {
  $CommandLine = "-File `"" + $MyInvocation.MyCommand.Path + "`" " + $MyInvocation.UnboundArguments
  Start-Process -FilePath PowerShell.exe -Verb Runas -ArgumentList $CommandLine
  Exit
 }
}

$onedrive = Get-Process OneDrive -ErrorAction SilentlyContinue
if ($onedrive) {
    taskkill /F /T /IM OneDrive.exe |Out-Null
    }
  Remove-Variable onedrive

$googledrivefs = Get-Process GoogleDriveFS -ErrorAction SilentlyContinue
if ($googledrivefs) {
    taskkill /F /T /IM GoogleDriveFS.exe |Out-Null
    }
  Remove-Variable googledrivefs

#

#

& "C:\Users\yen\source\scrips\Toggle Defender.ps1" 

