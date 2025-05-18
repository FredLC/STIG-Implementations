<#
.SYNOPSIS
    This PowerShell script enables PowerShell transcription and sets an output directory for transcripts.
.NOTES
    Author          : Fred Lefebvre
    LinkedIn        : linkedin.com/in/FredLC/
    GitHub          : github.com/FredLC
    Date Created    : 2025-05-17
    Last Modified   : 2025-05-17
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-CC-000327

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    PS C:\> .\WN10-CC-000327.ps1 
#>

# Define registry path
$regPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\PowerShell\Transcription"

# Create the path if it doesn't exist
if (-not (Test-Path $regPath)) {
    New-Item -Path $regPath -Force | Out-Null
}

# Enable transcription (set to 1)
New-ItemProperty -Path $regPath -Name "EnableTranscripting" -Value 1 -PropertyType DWord -Force

# Optional: Set a secure output directory for transcripts
$transcriptDir = "C:\Transcripts"  # Ideally use a secure network share or central log server path
New-ItemProperty -Path $regPath -Name "OutputDirectory" -Value $transcriptDir -PropertyType String -Force

Write-Output "PowerShell transcription has been enabled. Output directory set to $transcriptDir"
