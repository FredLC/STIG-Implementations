<#
.SYNOPSIS
    This PowerShell script configures auditing for Object Access - File Share successes.
.NOTES
    Author          : Fred Lefebvre
    LinkedIn        : linkedin.com/in/FredLC/
    GitHub          : github.com/FredLC
    Date Created    : 2025-04-05
    Last Modified   : 2025-04-05
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-CC-000082

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    PS C:\> .\WN10-CC-000082.ps1 
#>

# Ensure script runs with admin privileges
if (-not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole(`
    [Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Warning "You must run this script as Administrator!"
    exit
}

# 1. Enable Subcategory Auditing (Audit: Force audit policy subcategory settings)
Write-Output "Enabling: Force audit policy subcategory settings to override category settings..."
secedit /export /cfg "$env:TEMP\secpol.cfg"

(Get-Content "$env:TEMP\secpol.cfg").ForEach({
    if ($_ -match "^AuditPolicySubCategorySettings") {
        $_ -replace "0", "1"
    } else {
        $_
    }
}) | Set-Content "$env:TEMP\secpol.cfg"

secedit /configure /db secedit.sdb /cfg "$env:TEMP\secpol.cfg" /areas SECURITYPOLICY

# 2. Enable Audit: File Share Success
Write-Output "Configuring audit policy: Object Access >> File Share - Success..."
AuditPol /set /subcategory:"File Share" /success:enable

# 3. Confirm the setting
Write-Output "`nVerifying current File Share audit policy:"
AuditPol /get /subcategory:"File Share"
