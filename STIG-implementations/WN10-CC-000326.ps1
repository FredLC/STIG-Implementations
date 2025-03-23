<#
.SYNOPSIS
    Enables PowerShell script block logging
.NOTES
    Author          : Fred Lefebvre
    LinkedIn        : linkedin.com/in/FredLC/
    GitHub          : github.com/FredLC
    Date Created    : 2025-03-23
    Last Modified   : 2025-03-23
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-CC-000326

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    PS C:\> .\WN10-CC-000326.ps1 
#>

# Define the registry path and value
$registryPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\PowerShell\ScriptBlockLogging"
$valueName = "EnableScriptBlockLogging"
$desiredValue = 1

# Check if the key exists, if not create it
if (-not (Test-Path $registryPath)) {
    Write-Output "Registry path does not exist. Creating path: $registryPath"
    New-Item -Path $registryPath -Force | Out-Null
}

# Check current value
$currentValue = Get-ItemProperty -Path $registryPath -Name $valueName -ErrorAction SilentlyContinue

if ($null -eq $currentValue) {
    Write-Output "Value does not exist. Setting $valueName to $desiredValue"
    New-ItemProperty -Path $registryPath -Name $valueName -Value $desiredValue -PropertyType DWORD -Force | Out-Null
} elseif ($currentValue.$valueName -ne $desiredValue) {
    Write-Output "Incorrect value detected. Updating $valueName to $desiredValue"
    Set-ItemProperty -Path $registryPath -Name $valueName -Value $desiredValue -Force
} else {
    Write-Output "$valueName is already set to $desiredValue. No action needed."
}
