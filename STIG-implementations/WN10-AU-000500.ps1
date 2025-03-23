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
    PS C:\> .\WN10-AU-000500.ps1 
#>

# Define variables
$regPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\EventLog\Application"
$valueName = "MaxSize"
$minSizeKB = 32768

# Ensure the registry path exists
if (-not (Test-Path $regPath)) {
    New-Item -Path $regPath -Force | Out-Null
}

# Check current value
$currentValue = Get-ItemProperty -Path $regPath -Name $valueName -ErrorAction SilentlyContinue

if ($null -eq $currentValue) {
    # Set the value if it doesn't exist
    Set-ItemProperty -Path $regPath -Name $valueName -Value $minSizeKB -Type DWord
    Write-Host "MaxSize value created and set to $minSizeKB KB."
} elseif ($currentValue.$valueName -lt $minSizeKB) {
    # Update if it's below requirement
    Set-ItemProperty -Path $regPath -Name $valueName -Value $minSizeKB -Type DWord
    Write-Host "MaxSize value updated to $minSizeKB KB."
} else {
    Write-Host "MaxSize value is already $($currentValue.$valueName) KB, which meets or exceeds the requirement."
}
