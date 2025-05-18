<#
.SYNOPSIS
    This PowerShell script configures Windows to prioritize ECC Curves with longer key lengths.
.NOTES
    Author          : Fred Lefebvre
    LinkedIn        : linkedin.com/in/FredLC/
    GitHub          : github.com/FredLC
    Date Created    : 2025-03-23
    Last Modified   : 2025-03-23
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-CC-000052

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Make sure to run as administrator and restart the system.
    PS C:\> .\WN10-CC-000052.ps1 
#>

# Define registry path
$regPath = "HKLM:\SOFTWARE\Policies\Microsoft\Cryptography\Configuration\SSL\00010002"

# Ensure the registry path exists
if (-not (Test-Path $regPath)) {
    New-Item -Path $regPath -Force | Out-Null
}

# Define the desired ECC curve order
[string[]]$eccCurves = @("NistP384", "NistP256")

# Set the REG_MULTI_SZ value
Set-ItemProperty -Path $regPath -Name "EccCurves" -Value $eccCurves

# Confirm the setting
$check = Get-ItemProperty -Path $regPath -Name "EccCurves"
Write-Output "ECC Curves configured as: $($check.EccCurves -join ', ')"
