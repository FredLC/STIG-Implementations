<#
.SYNOPSIS
    This PowerShell script disables camera access from the logon screen.
.NOTES
    Author          : Fred Lefebvre
    LinkedIn        : linkedin.com/in/FredLC/
    GitHub          : github.com/FredLC
    Date Created    : 2025-03-23
    Last Modified   : 2025-03-23
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-CC-000005

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    PS C:\> .\WN10-CC-000005.ps1 
#>

# Define registry path and value
$regPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Personalization"
$regName = "NoLockScreenCamera"
$regValue = 1

# Create the registry key if it doesn't exist
if (-not (Test-Path $regPath)) {
    New-Item -Path $regPath -Force | Out-Null
    Write-Output "Created registry path: $regPath"
}

# Set the registry value
Set-ItemProperty -Path $regPath -Name $regName -Type DWord -Value $regValue
Write-Output "Set $regName to $regValue under $regPath"

# Verify the value
$currentValue = (Get-ItemProperty -Path $regPath -Name $regName).$regName
if ($currentValue -eq $regValue) {
    Write-Output "Verification successful: $regName is set to $regValue"
} else {
    Write-Output "Verification failed: $regName is not set correctly"
}