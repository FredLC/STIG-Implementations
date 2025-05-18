<#
.SYNOPSIS
    This PowerShell script configures the default autorun behavior to prevent autorun commands.
.NOTES
    Author          : Fred Lefebvre
    LinkedIn        : linkedin.com/in/FredLC/
    GitHub          : github.com/FredLC
    Date Created    : 2025-05-17
    Last Modified   : 2025-05-17
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-CC-000185

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    PS C:\> .\WN10-CC-000185.ps1 
#>

# Define the registry path and value
$regPath = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer"
$regName = "NoAutorun"
$regValue = 1

# Check if the registry path exists, create it if it doesn't
if (-not (Test-Path $regPath)) {
    New-Item -Path $regPath -Force | Out-Null
}

# Set the NoAutorun value to 1 (disable autorun)
New-ItemProperty -Path $regPath -Name $regName -Value $regValue -PropertyType DWord -Force | Out-Null

Write-Output "Autorun has been disabled by setting $regName to $regValue at $regPath."
