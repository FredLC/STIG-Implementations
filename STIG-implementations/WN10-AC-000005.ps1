<#
.SYNOPSIS
    This PowerShell script configures the account lockout duration to 15 minutes.
.NOTES
    Author          : Fred Lefebvre
    LinkedIn        : linkedin.com/in/FredLC/
    GitHub          : github.com/FredLC
    Date Created    : 2025-05-17
    Last Modified   : 2025-05-17
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-AC-000005

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    PS C:\> .\WN10-AC-000005.ps1 
#>

# Check current lockout duration
$currentDuration = (net accounts) | Select-String "Lockout duration" | ForEach-Object {
    ($_ -split ":")[1].Trim() -replace "minutes", "" -as [int]
}

# If not compliant, set to 15 minutes
if ($currentDuration -lt 15 -and $currentDuration -ne 0) {
    Write-Output "Current Lockout Duration: $currentDuration minute(s) — Updating to 15 minutes."
    net accounts /lockoutduration:15
} else {
    Write-Output "Lockout Duration already compliant (Current: $currentDuration minute(s)). No changes made."
}
