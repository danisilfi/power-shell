
Param(
	[string] $ADServer

)

import-module ActiveDirectory
Get-ADUser -Filter * -SearchBase $ADServer | export-csv -path .\ADUsers.scv

# Example of use: .\ExportADUsers.ps1 "DC=example,DC=local"