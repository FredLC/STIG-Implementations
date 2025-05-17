<#
.SYNOPSIS
    This PowerShell script disables solicited Remote Assistance.
.NOTES
    Author          : Fred Lefebvre
    LinkedIn        : linkedin.com/in/FredLC/
    GitHub          : github.com/FredLC
    Date Created    : 2025-04-05
    Last Modified   : 2025-04-05
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-CC-000155

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    PS C:\> .\WN10-CC-000155.ps1 
#>

$registryPath = 'HKLM:\SOFTWARE\Policies\Microsoft\Windows NT\Terminal Services'
$valueName = 'fAllowToGetHelp'
$desiredValue = 0

# Create the registry path if it does not exist
if (-not (Test-Path $registryPath)) {
    New-Item -Path $registryPath -Force | Out-Null
}

# Set the value to disable solicited remote assistance
Set-ItemProperty -Path $registryPath -Name $valueName -Value $desiredValue -Type DWord

# Confirm the change
$currentValue = Get-ItemProperty -Path $registryPath -Name $valueName
if ($currentValue.$valueName -eq $desiredValue) {
    Write-Output "Solicited Remote Assistance has been successfully disabled."
} else {
    Write-Warning "Failed to apply the setting."
}
