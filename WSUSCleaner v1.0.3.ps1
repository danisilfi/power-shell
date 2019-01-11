

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

	 1 = Decline Superseeded UpdateServices 
	 2 = Decline Expired updates
	 3 = Decline updates for Itanium computers
	 4 = Decline updates for 32-bit computers
	 5 = Decline Windows XP updates
	 6 = Decline updates for Internet Explorer 7
	 7 = Decline updates for Internet Explorer 8
	 8 = Decline updates for Internet Explorer 9
	 9 = Decline updates for Beta products and Beta updates
	10 = Decline updates for Embedded version of Windows
	11 = Decline Rollup updates
	12 = Decline ALL previous updates (except Superseeded) 
	13 = Delete all declined updates
	 0 = Exit
   
   
	
   
   Your selection is'
   #Superseeded
   if ($selection -eq "1"){
		cls
		$updates = $wsus.GetUpdates()
		$updatestodecline = $updates | where {$_.IsDeclined -eq $false -and (
		$_.IsSuperseded -eq $true)}
		
		$changemade = $false
		if ($reportonly) {
			write-host "ReportOnly was set to true, so not making any change"
		}else{	
			$changemade = $true
			$updatestodecline | %{$_.Decline()}

		}
		$wsus.GetUpdates() | Where {$_.IsSuperseded -eq $true} | ForEach-Object {SuperseededLog $_.Title}
		write-host "Log saved in .\Superseeded.log" -foregroundcolor "yellow"
		Write-Host "Press any key to continue ..."
		$x = $host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
		
   }
   #Expired
   elseif ($selection -eq "2"){
		cls
		$updates = $wsus.GetUpdates()
		$updatestodecline = $updates | where {$_.IsDeclined -eq $false -and (
		$_.PublicationState -eq "Expired")}
		
		$changemade = $false
		if ($reportonly) {
			write-host "ReportOnly was set to true, so not making any change"
		}else{	
			$changemade = $true
			$updatestodecline | %{$_.Decline()}

		}
		write-host "Log saved in .\UpdatesDeclined.log" -foregroundcolor "yellow"
		Write-Host "Press any key to continue ..."
		$x = $host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
   }
   #Itanium
   elseif ($selection -eq "3"){
		cls
		$updates = $wsus.GetUpdates()
		$updatestodecline = $updates | where {$_.IsDeclined -eq $false -and (
		$_.Title -match "ia64" -or $_.Title -match "Itanium")}
		
		$changemade = $false
		if ($reportonly) {
			write-host "ReportOnly was set to true, so not making any change"
		}else{	
			$changemade = $true
			$updatestodecline | %{$_.Decline()}

		}
		write-host "Log saved in .\UpdatesDeclined.log" -foregroundcolor "yellow"
		Write-Host "Press any key to continue ..."
		$x = $host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
   }
   
   #32-bit computers
   elseif ($selection -eq "4"){
		cls
		$updates = $wsus.GetUpdates()
		$updatestodecline = $updates | where {$_.IsDeclined -eq $false -and (
		$_.LegacyName -match "x86")}
		
		$changemade = $false
		if ($reportonly) {
			write-host "ReportOnly was set to true, so not making any change"
		}else{	
			$changemade = $true
			$updatestodecline | %{$_.Decline()}

		}
		write-host "Log saved in .\UpdatesDeclined.log" -foregroundcolor "yellow"
		Write-Host "Press any key to continue ..."
		$x = $host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
   }
   #XP
   elseif ($selection -eq "5") {
		cls
		$updates = $wsus.GetUpdates()
		$updatestodecline = $updates | where {$_.IsDeclined -eq $false -and (
		$_.LegacyName -match "XP" -or $_.producttitles -match "XP")}
		
		$changemade = $false
		if ($reportonly) {
			write-host "ReportOnly was set to true, so not making any change"
		}else{	
			$changemade = $true
			$updatestodecline | %{$_.Decline()}

		}
		write-host "Log saved in .\UpdatesDeclined.log" -foregroundcolor "yellow"
		Write-Host "Press any key to continue ..."
		$x = $host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
   }
   #IE7
   elseif ($selection -eq "6") {
		cls
		$updates = $wsus.GetUpdates()
		$updatestodecline = $updates | where {$_.IsDeclined -eq $false -and (
		$_.title -match "Internet Explorer 7")}
		
		$changemade = $false
		if ($reportonly) {
			write-host "ReportOnly was set to true, so not making any change"
		}else{	
			$changemade = $true
			$updatestodecline | %{$_.Decline()}

		}
		write-host "Log saved in C.\UpdatesDeclined.log" -foregroundcolor "yellow"
		Write-Host "Press any key to continue ..."
		$x = $host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
   }
   #IE8
   elseif ($selection -eq "7") {
		cls
		$updates = $wsus.GetUpdates()
		$updatestodecline = $updates | where {$_.IsDeclined -eq $false -and (
		$_.title -match "Internet Explorer 8")}
		
		$changemade = $false
		if ($reportonly) {
			write-host "ReportOnly was set to true, so not making any change"
		}else{	
			$changemade = $true
			$updatestodecline | %{$_.Decline()}

		}
		write-host "Log saved in .\UpdatesDeclined.log" -foregroundcolor "yellow"
		Write-Host "Press any key to continue ..."
		$x = $host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
	
   }
   #IE9
   elseif ($selection -eq "8") {
		cls
		$updates = $wsus.GetUpdates()
		$updatestodecline = $updates | where {$_.IsDeclined -eq $false -and (
		$_.title -match "Internet Explorer 9")}
		
		$changemade = $false
		if ($reportonly) {
			write-host "ReportOnly was set to true, so not making any change"
		}else{	
			$changemade = $true
			$updatestodecline | %{$_.Decline()}

		}
		write-host "Log saved in .\UpdatesDeclined.log" -foregroundcolor "yellow"
		Write-Host "Press any key to continue ..."
		$x = $host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
   }
   #Beta
   elseif ($selection -eq "9") {
		cls
		$updates = $wsus.GetUpdates()
		$updatestodecline = $updates | where {$_.IsDeclined -eq $false -and (
		$_.Title -match "Beta")}
		
		$changemade = $false
		if ($reportonly) {
			write-host "ReportOnly was set to true, so not making any change"
		}else{	
			$changemade = $true
			$updatestodecline | %{$_.Decline()}

		}
		write-host "Log saved in C.\UpdatesDeclined.log" -foregroundcolor "yellow"
		Write-Host "Press any key to continue ..."
		$x = $host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
   }
   #Embedded
   elseif ($selection -eq "10") {
		cls
		$updates = $wsus.GetUpdates()
		$updatestodecline = $updates | where {$_.IsDeclined -eq $false -and (
		$_.title -match "Embedded")}
		
		$changemade = $false
		if ($reportonly) {
			write-host "ReportOnly was set to true, so not making any change"
		}else{	
			$changemade = $true
			$updatestodecline | %{$_.Decline()}

		}
		write-host "Log saved in .\UpdatesDeclined.log" -foregroundcolor "yellow"
		Write-Host "Press any key to continue ..."
		$x = $host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
	
   }
   #Rollup
   elseif ($selection -eq "11"){
		cls
		$updates = $wsus.GetUpdates()
		$updatestodecline = $updates | where {$_.IsDeclined -eq $false -and (
		$_.Title -match "Rollup" )}
		
		$changemade = $false
		if ($reportonly) {
			write-host "ReportOnly was set to true, so not making any change"
		}else{	
			$changemade = $true
			$updatestodecline | %{$_.Decline()}

		}
		write-host "Log saved in .\UpdatesDeclined.log" -foregroundcolor "yellow"
		Write-Host "Press any key to continue ..."
		$x = $host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
   }
   #Decline all the previous updates excepts superseed
   elseif($selection -eq "12"){
		cls
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
		$_.Title -match "Rollup")}
		
		$changemade = $false
		if ($reportonly) {
			write-host "ReportOnly was set to true, so not making any change"
		}else{	
			$changemade = $true
			$updatestodecline | %{$_.Decline()}

		}
		write-host "Log saved in .\UpdatesDeclined.log" -foregroundcolor "yellow"
		Write-Host "Press any key to continue ..."
		$x = $host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
   
   }
   # Delete all the declined updates
   elseif ($selection -eq "13"){

		cls
		Write-Host "CAUTION: If you choose "yes" ALL the declined updates will be deleted with no possibility to recover."  -foregroundcolor "yellow"
		$selection2 = Read-Host 'Do you want to continue? (y/n)'
		if ($selection2 -eq "y"){
			cls
			$date2 = Get-Date
			LogWrite2 " "
			LogWrite2 "------------------"
			LogWrite2 "Updates Deleted:"
			LogWrite2 $date2
			LogWrite2 "------------------"
			LogWrite2 " "
			$wsus.GetUpdates() | Where {$_.IsDeclined -eq $true} | ForEach-Object {$wsus.DeleteUpdate($_.Id.UpdateId.ToString()); Write-Host $_.Title removed -foregroundcolor "red"; LogWrite2 $_.Title removed }
		}
		
		write-host "Log saved in .\UpdatesDeleted.log" -foregroundcolor "yellow"
		Write-Host "Press any key to continue ..."
		$x = $host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")

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