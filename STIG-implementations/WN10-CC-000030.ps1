<#
.SYNOPSIS
    This PowerShell script disables ICMP redirects. 
.NOTES
    Author          : Fred Lefebvre
    LinkedIn        : linkedin.com/in/FredLC/
    GitHub          : github.com/FredLC
    Date Created    : 2025-05-17
    Last Modified   : 2025-05-17
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

# Set the registry key to disable ICMP redirects
$registryPath = "HKLM:\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters"
$valueName = "EnableICMPRedirect"
$desiredValue = 0

# Create or update the registry value
New-ItemProperty -Path $registryPath -Name $valueName -Value $desiredValue -PropertyType DWord -Force

# Output confirmation
Write-Output "Registry value '$valueName' set to '$desiredValue' at '$registryPath'"
