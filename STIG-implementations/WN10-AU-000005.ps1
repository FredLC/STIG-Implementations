<#
.SYNOPSIS
    This PowerShell script enables auditing of Account Logon - Credential Validation failures.
.NOTES
    Author          : Fred Lefebvre
    LinkedIn        : linkedin.com/in/FredLC/
    GitHub          : github.com/FredLC
    Date Created    : 2025-03-23
    Last Modified   : 2025-03-23
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-CC-000005

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Make sure to run as administrator.
    PS C:\> .\WN10-CC-000005.ps1
#>

# Ensure advanced audit policy settings are enforced
# This sets "Audit: Force audit policy subcategory settings (Windows Vista or later) to override audit policy category settings" to Enabled
secedit /export /cfg C:\Windows\Temp\auditpol.cfg
(Get-Content C:\Windows\Temp\auditpol.cfg).replace("MACHINE\System\CurrentControlSet\Control\Lsa\SCENoApplyLegacyAuditPolicy = 0","MACHINE\System\CurrentControlSet\Control\Lsa\SCENoApplyLegacyAuditPolicy = 1") | Set-Content C:\Windows\Temp\auditpol.cfg
secedit /configure /db secedit.sdb /cfg C:\Windows\Temp\auditpol.cfg /areas SECURITYPOLICY
Remove-Item C:\Windows\Temp\auditpol.cfg

# Configure "Audit Credential Validation" for Failure
AuditPol /set /subcategory:"Credential Validation" /failure:enable

# Verify setting
AuditPol /get /subcategory:"Credential Validation"
