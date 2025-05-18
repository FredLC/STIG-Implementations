<#
.SYNOPSIS
    This PowerShell script prevents the use of DES and RC4 for Kerberos.
.NOTES
    Author          : Fred Lefebvre
    LinkedIn        : linkedin.com/in/FredLC/
    GitHub          : github.com/FredLC
    Date Created    : 2025-04-13
    Last Modified   : 2025-04-13
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-SO-000190

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    PS C:\> .\WN10-SO-000190.ps1 
#>

$regPath = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System\Kerberos\Parameters"
$regName = "SupportedEncryptionTypes"
$desiredValue = 0x7FFFFFF8

try {
    # Ensure the registry path exists
    if (-not (Test-Path $regPath)) {
        New-Item -Path $regPath -Force | Out-Null
        Write-Output "Created registry path: $regPath"
    }

    # Check if the value already exists and is correct
    $currentValue = Get-ItemProperty -Path $regPath -Name $regName -ErrorAction SilentlyContinue | Select-Object -ExpandProperty $regName -ErrorAction SilentlyContinue

    if ($currentValue -eq $desiredValue) {
        Write-Output "Registry value already set correctly: $regName = $desiredValue"
    } else {
        # Create or update the registry value
        Set-ItemProperty -Path $regPath -Name $regName -Value $desiredValue -Type DWord
        Write-Output "Set $regName to $desiredValue at $regPath"
    }

} catch {
    Write-Error "Failed to update registry: $_"
}
