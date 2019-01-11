

Param(
	[string]$wsusserver = "wsus.midominio.com",
	[switch]$secure = $false,
	[int]$portNumber = 443
)

Write-Host "Connecting with the WSUS Server, please wait..." -foregroundcolor "yellow"
$reportonly

[void][reflection.assembly]::LoadWithPartialName("Microsoft.UpdateServices.Administration")
$wsus = [Microsoft.UpdateServices.Administration.AdminProxy]::GetUpdateServer($wsusserver,$secure,$portNumber);
if ($wsus -eq $Null) {
	write-error "Unable to contact WSUSServer $wsusserver"
}else{
Write-Host "Connection established" 

$Logfile = ".\UpdatesDeclined.log"
Function LogWrite
{
   Param ([string]$logstring)

   Add-content $Logfile -value $logstring     
}

$Logfile2 = ".\UpdatesDeleted.log"
Function LogWrite2
{
   Param ([string]$logstring)

   Add-content $Logfile2 -value $logstring     
}

$LogSuperseed = ".\Superseeded.log"
Function SuperseededLog
{
	Param ([string]$logstring)
	Add-content $LogSuperseed -value $logstring
}

do {
cls
Write-Host ""
Write-Host "Connection established with $wsusserver" -foregroundcolor "yellow"
Write-Host ""
Write-Host ""

$selection=Read-Host 'Select a task to do:

	 1 = Delete the WSUS Database 
	 
	 0 = Exit
   	
   
   Your selection is'
   
   if($selection -eq "1"){
		cls
		write-Host "Declining all updates..."
		$updates = $wsus.GetUpdates()
		$updatestodecline = $updates | where {$_.IsDeclined -eq $false -and (
		$_.PublicationState -eq "Expired" -or
		$_.Title -match "ia64" -or $_.Title -match "Itanium" -or
		$_.LegacyName -match "x86" -or
		$_.LegacyName -match "XP" -or $_.producttitles -match "XP" -or
		$_.title -match "Internet Explorer 7" -or
		$_.title -match "Internet Explorer 8" -or
		$_.title -match "Internet Explorer 9" -or
		$_.Title -match "Beta" -or
		$_.title -match "Embedded" -or
		$_.Title -match "Rollup" -or
		$_.IsSuperseded -eq $true -or 
		$_.Title -match "Update" -or
		$_.Title -match "Security" -or
		$_.Title -match "Critical")}
		
		$changemade = $false
		if ($reportonly) {
			write-host "ReportOnly was set to true, so not making any change"
		}else{	
			$changemade = $true
			$updatestodecline | %{$_.Decline()}

		}
		write-host "Log saved in .\UpdatesDeclined.log" -foregroundcolor "yellow"

		write-host "Deleting all updates from DDBB..."
		$date2 = Get-Date
			LogWrite2 " "
			LogWrite2 "------------------"
			LogWrite2 "Updates Deleted:"
			LogWrite2 $date2
			LogWrite2 "------------------"
			LogWrite2 " "
		$wsus.GetUpdates() | Where {$_.IsDeclined -eq $true} | ForEach-Object {$wsus.DeleteUpdate($_.Id.UpdateId.ToString()); Write-Host $_.Title removed -foregroundcolor "red"; LogWrite2 $_.Title removed }
		write-host "Log saved in .\UpdatesDeleted.log" -foregroundcolor "yellow"
		
		write-host "Deleting WsusContent Folder..."
		Remove-item -Recurse -Force -ErrorAction SilentlyContinue C:\WSUS\WsusContent
		write-host "Deleting previous .cab and .log files"
		Remove-item -Path "C:\Program Files\Update Services\Tools\*.cab"
		Remove-item -Path "C:\Program Files\Update Services\Tools\*.log"
   }
   # Exit the script and save the information about updates in file called UpdatesDeclines.log
   elseif ($selection -eq "0"){
			$date = Get-Date
			LogWrite " "
			LogWrite "------------------"
			LogWrite "Updates Declined:"
			LogWrite $date
			LogWrite "------------------"
			LogWrite " "
		$wsus.GetUpdates() | Where {$_.IsDeclined -eq $true} | ForEach-Object {LogWrite $_.Title}
		Remove-Variable * -ErrorAction SilentlyContinue
		cls
		Exit-PSSession
		Exit
   
   }
   
   else {

	cls
	Exit-PSSession
	Exit
	
	}
	
}

while (1 -eq 1)
}