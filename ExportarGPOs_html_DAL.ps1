Import-Module grouppolicy
Write-Host "Extracting all the GPO's of Active Directory"
Get-GPO -All | % {$_.GenerateReport('html') | Out-File "$($_.DisplayName).htm"}
Write-Host "Done"