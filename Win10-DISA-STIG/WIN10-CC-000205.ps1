<#
.SYNOPSIS
    This PowerShell script sets the telemetry level to Security or Basic depending on the Enterprise needs.
.NOTES
    Author          : Fred Lefebvre
    LinkedIn        : linkedin.com/in/FredLC/
    GitHub          : github.com/FredLC
    Date Created    : 2025-03-23
    Last Modified   : 2025-03-23
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-CC-000205

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    PS C:\> .\WN10-CC-000205.ps1 
#>

# Define Registry Path
$registryPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DataCollection"

# Ensure the key exists
if (-not (Test-Path $registryPath)) {
    New-Item -Path $registryPath -Force
}

# Set AllowTelemetry to 0 (Security) or 1 (Basic)
# Adjust this value depending on your organization's policy
$desiredValue = 0  # Set to 1 if you need Basic level telemetry

# Set the registry value
Set-ItemProperty -Path $registryPath -Name "AllowTelemetry" -Value $desiredValue -Type DWord

# Verify the setting
$currentValue = Get-ItemProperty -Path $registryPath -Name "AllowTelemetry"

if ($currentValue.AllowTelemetry -eq $desiredValue) {
    Write-Host "AllowTelemetry successfully set to $desiredValue"
} else {
    Write-Host "Failed to set AllowTelemetry properly."
}
