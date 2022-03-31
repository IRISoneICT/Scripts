#Author       : Dennis van Hamond
# Creation Date: 03-12-2021
# Usage        : Setup FSLogix
 
#********************************************************************************
# Date                         Version      Changes
#------------------------------------------------------------------------
# 03/12/2021                     1.0        Intial Version
#
#
#*********************************************************************************
#
#>
 
Param (        
	[Parameter(Mandatory=$true)]
		[string]$ProfilePath
)
 
#######################################
#    FSLogix User Profile Settings    #
#######################################
Add-Content -LiteralPath C:\Temp\New-WVDSessionHost.log "Configure FSLogix Profile Settings"
Push-Location 
Set-Location HKLM:\SOFTWARE\
New-Item `
	-Path HKLM:\SOFTWARE\FSLogix `
	-Name Profiles `
	-Value "" `
	-Force
New-Item `
	-Path HKLM:\Software\FSLogix\Profiles\ `
	-Name Apps `
	-Force
Set-ItemProperty `
	-Path HKLM:\Software\FSLogix\Profiles `
	-Name "Enabled" `
	-Type "Dword" `
	-Value "1"
New-ItemProperty `
	-Path HKLM:\Software\FSLogix\Profiles `
	-Name "CCDLocations" `
	-Value "type=smb,connectionString=$ProfilePath" `
	-PropertyType MultiString `
	-Force
Set-ItemProperty `
	-Path HKLM:\Software\FSLogix\Profiles `
	-Name "SizeInMBs" `
	-Type "Dword" `
	-Value "30000"
Set-ItemProperty `
	-Path HKLM:\Software\FSLogix\Profiles `
	-Name "IsDynamic" `
	-Type "Dword" `
	-Value "1"
Set-ItemProperty `
	-Path HKLM:\Software\FSLogix\Profiles `
	-Name "VolumeType" `
	-Type String `
	-Value "vhdx"
Set-ItemProperty `
	-Path HKLM:\Software\FSLogix\Profiles `
	-Name "FlipFlopProfileDirectoryName" `
	-Type "Dword" `
	-Value "1" 
Set-ItemProperty `
	-Path HKLM:\Software\FSLogix\Profiles `
	-Name "SIDDirNamePattern" `
	-Type String `
	-Value "%username%%sid%"
Set-ItemProperty `
	-Path HKLM:\Software\FSLogix\Profiles `
	-Name "SIDDirNameMatch" `
	-Type String `
	-Value "%username%%sid%"
Set-ItemProperty `
	-Path HKLM:\Software\FSLogix\Profiles `
	-Name DeleteLocalProfileWhenVHDShouldApply `
	-Type DWord `
	-Value 1
Pop-Location
 
 
#############
#    END    #
#############
