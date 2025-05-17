<#
.SYNOPSIS
    This PowerShell script disables slide shows on the lock screen.
.NOTES
    Author          : Fred Lefebvre
    LinkedIn        : linkedin.com/in/FredLC/
    GitHub          : github.com/FredLC
    Date Created    : 2025-04-13
    Last Modified   : 2025-04-13
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-CC-000010

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    PS C:\> .\WN10-CC-000010.ps1 
#>

# Define the registry path and key
$registryPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Personalization"
$registryKey = "NoLockScreenSlideshow"
$registryValue = 1

# Check if the registry path exists, create if necessary
if (-not (Test-Path $registryPath)) {
    New-Item -Path $registryPath -Force
}

# Set the registry key value
Set-ItemProperty -Path $registryPath -Name $registryKey -Value $registryValue -Type DWord

Write-Host "Slide shows on lock screen disabled." -ForegroundColor Green
