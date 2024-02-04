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

# List of files to be renamed
$filesToRename = @(
    "C:\Program Files (x86)\Adobe\Adobe Sync\CoreSync\CoreSync.exe",
    "C:\Program Files\Adobe\Adobe Creative Cloud Experience\CCXProcess.exe",
    "C:\Program Files (x86)\Common Files\Adobe\Adobe Desktop Common\ADS\Adobe Desktop Service.exe",
    "C:\Program Files\Common Files\Adobe\Creative Cloud Libraries\CCLibrary.exe",
    "C:\Program Files\Adobe\Acrobat DC\Acrobat\AdobeCollabSync.exe"
)

# Confirm before proceeding
$confirmation = Get-Confirmation
if (-not $confirmation) {
    Write-Host "Script execution aborted."
    exit
}

# Rename files
foreach ($file in $filesToRename) {
    $newName = $file -replace '\.exe$', '.exeNO'
    Write-Host "Renaming $file to $newName"
    Rename-Item $file $newName
}

Write-Host "`nFiles renamed successfully!"
