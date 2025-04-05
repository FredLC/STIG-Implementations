<#
.SYNOPSIS
    This PowerShell script enables Structured Exception Handling Overwrite Protection (SEHOP).
.NOTES
    Author          : Fred Lefebvre
    LinkedIn        : linkedin.com/in/FredLC/
    GitHub          : github.com/FredLC
    Date Created    : 2025-04-05
    Last Modified   : 2025-04-05
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-CC-000150

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    PS C:\> .\WN10-CC-000150.ps1 
#>

$regPath = "HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\kernel"
$valueName = "DisableExceptionChainValidation"
$desiredValue = 0

# Create registry path if it doesn't exist
if (-not (Test-Path $regPath)) {
    New-Item -Path $regPath -Force | Out-Null
}

# Set the correct value
Set-ItemProperty -Path $regPath -Name $valueName -Value $desiredValue -Type DWord
Write-Output "SEHOP has been ENABLED (Set DisableExceptionChainValidation = 0)"
