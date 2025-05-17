<#
.SYNOPSIS
    This PowerShell script enables Audit Policy subcategories enforcement.
.NOTES
    Author          : Fred Lefebvre
    LinkedIn        : linkedin.com/in/FredLC/
    GitHub          : github.com/FredLC
    Date Created    : 2025-03-23
    Last Modified   : 2025-03-23
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-CC-000030

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    PS C:\> .\WN10-CC-000030.ps1 
#>

# Define the registry path and value
$registryPath = "HKLM:\SYSTEM\CurrentControlSet\Control\Lsa"
$valueName = "SCENoApplyLegacyAuditPolicy"
$desiredValue = 1

# Check if the registry key exists
if (-not (Test-Path $registryPath)) {
    Write-Output "Registry path does not exist. Creating path..."
    New-Item -Path $registryPath -Force | Out-Null
}

# Check current value
$currentValue = Get-ItemProperty -Path $registryPath -Name $valueName -ErrorAction SilentlyContinue

if ($null -eq $currentValue) {
    Write-Output "Value does not exist. Creating value..."
    New-ItemProperty -Path $registryPath -Name $valueName -PropertyType DWord -Value $desiredValue -Force | Out-Null
    Write-Output "Audit policy subcategory enforcement has been enabled."
} elseif ($currentValue.$valueName -ne $desiredValue) {
    Write-Output "Value exists but is not set correctly. Updating value..."
    Set-ItemProperty -Path $registryPath -Name $valueName -Value $desiredValue
    Write-Output "Audit policy subcategory enforcement has been updated."
} else {
    Write-Output "Audit policy subcategory enforcement is already correctly configured."
}
