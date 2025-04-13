<#
.SYNOPSIS
    This PowerShell script disables WinRM basic authentication (client).
.NOTES
    Author          : Fred Lefebvre
    LinkedIn        : linkedin.com/in/FredLC/
    GitHub          : github.com/FredLC
    Date Created    : 2025-04-13
    Last Modified   : 2025-04-13
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-CC-000330

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    PS C:\> .\WN10-CC-000330.ps1 
#>

$registryPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WinRM\Client"
$registryName = "AllowBasic"
$valueData = 0

# Check if the registry path exists
if (-not (Test-Path $registryPath)) {
    New-Item -Path $registryPath -Force
}

# Set the registry value to disable Basic authentication (0)
Set-ItemProperty -Path $registryPath -Name $registryName -Value $valueData -Type DWord
Write-Host "Basic authentication for WinRM has been disabled." -ForegroundColor Green