<#
.SYNOPSIS
    This PowerShell script disables the Application Compatibility Program Inventory.
.NOTES
    Author          : Fred Lefebvre
    LinkedIn        : linkedin.com/in/FredLC/
    GitHub          : github.com/FredLC
    Date Created    : 2025-03-23
    Last Modified   : 2025-03-23
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-CC-000175

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    PS C:\> .\WN10-CC-000175.ps1 
#>

# Define registry path and values
$registryPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\AppCompat"
$valueName = "DisableInventory"
$desiredValue = 1

# Check if the path exists, if not, create it
if (-not (Test-Path $registryPath)) {
    New-Item -Path $registryPath -Force | Out-Null
}

# Set the registry value
Set-ItemProperty -Path $registryPath -Name $valueName -Value $desiredValue -Type DWord

# Verify the value
$currentValue = Get-ItemPropertyValue -Path $registryPath -Name $valueName
if ($currentValue -eq $desiredValue) {
    Write-Host "STIG setting applied successfully. DisableInventory is set to 1."
} else {
    Write-Host "Failed to apply the STIG setting. Please check manually."
}
