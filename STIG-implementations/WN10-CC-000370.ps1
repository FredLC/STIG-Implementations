<#
.SYNOPSIS
    This PowerShell script disables the convenience PIN.
.NOTES
    Author          : Fred Lefebvre
    LinkedIn        : linkedin.com/in/FredLC/
    GitHub          : github.com/FredLC
    Date Created    : 2025-03-23
    Last Modified   : 2025-03-23
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-CC-000370

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    PS C:\> .\WN10-CC-000370.ps1 
#>

# Define registry path and values
$registryPath = "HKLM:\Software\Policies\Microsoft\Windows\System"
$valueName = "AllowDomainPINLogon"
$desiredValue = 0

# Check if the registry path exists, if not, create it
if (-not (Test-Path $registryPath)) {
    New-Item -Path $registryPath -Force | Out-Null
}

# Set the registry value to disable the convenience PIN sign-in
New-ItemProperty -Path $registryPath -Name $valueName -PropertyType DWORD -Value $desiredValue -Force | Out-Null

# Verify and output the result
$currentValue = Get-ItemPropertyValue -Path $registryPath -Name $valueName
if ($currentValue -eq $desiredValue) {
    Write-Output "Compliance enforced: Convenience PIN sign-in is disabled."
} else {
    Write-Output "Failed to enforce compliance."
}
