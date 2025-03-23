<#
.SYNOPSIS
    This PowerShell script
.NOTES
    Author          : Fred Lefebvre
    LinkedIn        : linkedin.com/in/FredLC/
    GitHub          : github.com/FredLC
    Date Created    : 2025-03-23
    Last Modified   : 2025-03-23
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-CC-000295

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    PS C:\> .\WN10-CC-000295.ps1 
#>

# Define the registry path
$registryPath = "HKLM:\SOFTWARE\Policies\Microsoft\Internet Explorer\Feeds"

# Check if the registry key exists, if not create it
if (-not (Test-Path $registryPath)) {
    New-Item -Path $registryPath -Force | Out-Null
}

# Set the DisableEnclosureDownload value to 1
Set-ItemProperty -Path $registryPath -Name "DisableEnclosureDownload" -Value 1 -Type DWord

# Verify the setting
$currentValue = Get-ItemProperty -Path $registryPath -Name "DisableEnclosureDownload"
if ($currentValue.DisableEnclosureDownload -eq 1) {
    Write-Output "The setting has been applied successfully: DisableEnclosureDownload = 1"
} else {
    Write-Output "Failed to apply the setting."
}
