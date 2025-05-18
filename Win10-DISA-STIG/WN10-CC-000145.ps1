<#
.SYNOPSIS
    This PowerShell script ensures the user is prompted for a password on resume from sleep (on battery). 
.NOTES
    Author          : Fred Lefebvre
    LinkedIn        : linkedin.com/in/FredLC/
    GitHub          : github.com/FredLC
    Date Created    : 2025-05-17
    Last Modified   : 2025-05-17
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-CC-000145

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    PS C:\> .\WN10-CC-000145.ps1 
#>

# Define the registry path and value name
$regPath = "HKLM:\SOFTWARE\Policies\Microsoft\Power\PowerSettings\0e796bdb-100d-47d6-a2d5-f7d2daa51f51"
$valueName = "DCSettingIndex"
$valueData = 1

# Create the registry key if it does not exist
if (-not (Test-Path $regPath)) {
    New-Item -Path $regPath -Force | Out-Null
}

# Set the registry value
New-ItemProperty -Path $regPath -Name $valueName -Value $valueData -PropertyType DWord -Force

Write-Output "STIG WN10-CC-000145 implemented: Password on resume (battery) is now required."
