<#
.SYNOPSIS
    This PowerShell script disables basic authentication in Windows Remote Management Service (WinRM).
.NOTES
    Author          : Fred Lefebvre
    LinkedIn        : linkedin.com/in/FredLC/
    GitHub          : github.com/FredLC
    Date Created    : 2025-03-26
    Last Modified   : 2025-03-26
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-CC-000345

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    PS C:\> .\WN10-CC-000345.ps1 
#>

$regPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WinRM\Service"
$valueName = "AllowBasic"
$valueData = 0

# Create the registry path if it doesn't exist
if (-not (Test-Path $regPath)) {
    New-Item -Path $regPath -Force | Out-Null
}

# Set the value
Set-ItemProperty -Path $regPath -Name $valueName -Value $valueData -Type DWord

Write-Host "✔ Basic authentication has been disabled for WinRM." -ForegroundColor Green