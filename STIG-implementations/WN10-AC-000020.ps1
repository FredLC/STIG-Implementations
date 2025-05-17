<#
.SYNOPSIS
    This PowerShell script configures the password history size to 24.
.NOTES
    Author          : Fred Lefebvre
    LinkedIn        : linkedin.com/in/FredLC/
    GitHub          : github.com/FredLC
    Date Created    : 2025-04-05
    Last Modified   : 2025-04-05
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-AC-000020

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    PS C:\> .\WN10-AC-000020.ps1 
#>

# Create C:\temp folder if it doesn't exist
if (-Not (Test-Path -Path "C:\temp")) {
    New-Item -Path "C:\temp" -ItemType Directory | Out-Null
}

# Ensure the SecurityPolicy module is loaded
secedit /export /cfg C:\temp\secpol.cfg

# Read the exported security policy file
$policyPath = "C:\temp\secpol.cfg"
$policyLines = Get-Content $policyPath

# Modify or insert the password history value
$setting = "PasswordHistorySize"
$newValue = "24"

if ($policyLines -match "^$setting\s*=\s*\d+") {
    $policyLines = $policyLines -replace "^$setting\s*=\s*\d+", "$setting = $newValue"
} else {
    $policyLines += "$setting = $newValue"
}

# Save the modified policy file
$policyLines | Set-Content $policyPath

# Apply the updated security policy
secedit /configure /db C:\Windows\Security\Local.sdb /cfg $policyPath /areas SECURITYPOLICY

# Cleanup
Remove-Item $policyPath
