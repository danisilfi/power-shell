# Borrar OU's
Import-Module ActiveDirectory

$ROOT="DC=wordpress,DC=corp,DC=com"
#WP Users

Get-ADOrganizationalUnit -Identity "OU=WP Users,$ROOT" | Set-ADObject -ProtectedFromAccidentalDeletion:$false -PassThru
Remove-ADOrganizationalUnit -Identity "OU=WP Users,$ROOT"


#Desktops
Get-ADOrganizationalUnit -Identity "OU=Desktops,OU=WP Computers,$ROOT" | Set-ADObject -ProtectedFromAccidentalDeletion:$false -PassThru
Remove-ADOrganizationalUnit -Identity "OU=Desktops,OU=WP Computers,$ROOT"

#Laptops

Get-ADOrganizationalUnit -Identity "OU=Laptops,OU=WP Computers,$ROOT" | Set-ADObject -ProtectedFromAccidentalDeletion:$false -PassThru
Remove-ADOrganizationalUnit -Identity "OU=Laptops,OU=WP Computers,$ROOT"


#Applications

Get-ADOrganizationalUnit -Identity "OU=Applications,OU=Servers,OU=WP Computers,$ROOT" | Set-ADObject -ProtectedFromAccidentalDeletion:$false -PassThru
Remove-ADOrganizationalUnit -Identity "OU=Applications,OU=Servers,OU=WP Computers,$ROOT"

#BBDD

Get-ADOrganizationalUnit -Identity "OU=BBDD,OU=Servers,OU=WP Computers,$ROOT" | Set-ADObject -ProtectedFromAccidentalDeletion:$false -PassThru
Remove-ADOrganizationalUnit -Identity "OU=BBDD,OU=Servers,OU=WP Computers,$ROOT"

#WSUS

Get-ADOrganizationalUnit -Identity "OU=WSUS,OU=Servers,OU=WP Computers,$ROOT" | Set-ADObject -ProtectedFromAccidentalDeletion:$false -PassThru
Remove-ADOrganizationalUnit -Identity "OU=WSUS,OU=Servers,OU=WP Computers,$ROOT"


#File Server

Get-ADOrganizationalUnit -Identity "OU=File Server,OU=Servers,OU=WP Computers,$ROOT" | Set-ADObject -ProtectedFromAccidentalDeletion:$false -PassThru
Remove-ADOrganizationalUnit -Identity "OU=File Server,OU=Servers,OU=WP Computers,$ROOT"

#Servers


Get-ADOrganizationalUnit -Identity "OU=Servers,OU=WP Computers,$ROOT" | Set-ADObject -ProtectedFromAccidentalDeletion:$false -PassThru
Remove-ADOrganizationalUnit -Identity "OU=Servers,OU=WP Computers,$ROOT"


#WP Computers
Get-ADOrganizationalUnit -Identity "OU=WP Computers,$ROOT" | Set-ADObject -ProtectedFromAccidentalDeletion:$false -PassThru
Remove-ADOrganizationalUnit -Identity "OU=WP Computers,$ROOT"