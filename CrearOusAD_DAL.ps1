

Import-Module ActiveDirectory

$ROOT="DC=ejemplo,DC=local"


# Creacion de las OU's
$objDominio=[ADSI]"LDAP://DC=ejemplo,DC=local"
#WP Users
$objOU=$objDominio.Create("OrganizationalUnit","ou=WP Users")
$objOU.Put("description","OU de Usuarios")
$objOU.SetInfo()
Get-ADOrganizationalUnit -Identity "OU=WP Users,$ROOT" | Set-ADObject -ProtectedFromAccidentalDeletion:$true -PassThru

#WP Computers
$objOU=$objDominio.Create("OrganizationalUnit","ou=WP Computers")
$objOU.Put("description","OU de Equipos")
$objOU.SetInfo()
Get-ADOrganizationalUnit -Identity "OU=WP Computers,$ROOT" | Set-ADObject -ProtectedFromAccidentalDeletion:$true -PassThru
#---------------------------------------------------------------------------
#Desktops
$objDominio=[ADSI]"LDAP://OU=WP Computers,DC=wordpress,DC=corp,DC=com"
$objOU=$objDominio.Create("OrganizationalUnit","ou=Desktops")
$objOU.Put("description","OU de Equipos de sobremesa")
$objOU.SetInfo()
Get-ADOrganizationalUnit -Identity "OU=Desktops,OU=WP Computers,$ROOT" | Set-ADObject -ProtectedFromAccidentalDeletion:$true -PassThru


#Laptops

$objOU=$objDominio.Create("OrganizationalUnit","ou=Laptops")
$objOU.Put("description","OU de Equipos portatiles")
$objOU.SetInfo()
Get-ADOrganizationalUnit -Identity "OU=Laptops,OU=WP Computers,$ROOT" | Set-ADObject -ProtectedFromAccidentalDeletion:$true -PassThru


#Servers

$objOU=$objDominio.Create("OrganizationalUnit","ou=Servers")
$objOU.Put("description","OU de Servidores")
$objOU.SetInfo()
Get-ADOrganizationalUnit -Identity "OU=Servers,OU=WP Computers,$ROOT" | Set-ADObject -ProtectedFromAccidentalDeletion:$true -PassThru

#Applications
$objDominio=[ADSI]"LDAP://OU=Servers,OU=WP Computers,DC=wordpress,DC=corp,DC=com"
$objOU=$objDominio.Create("OrganizationalUnit","ou=Applications")
$objOU.Put("description","OU de Servidores de Aplicación")
$objOU.SetInfo()
Get-ADOrganizationalUnit -Identity "OU=Applications,OU=Servers,OU=WP Computers,$ROOT" | Set-ADObject -ProtectedFromAccidentalDeletion:$true -PassThru

#BBDD

$objOU=$objDominio.Create("OrganizationalUnit","ou=BBDD")
$objOU.Put("description","OU de Servidores de BBDD")
$objOU.SetInfo()
Get-ADOrganizationalUnit -Identity "OU=BBDD,OU=Servers,OU=WP Computers,$ROOT" | Set-ADObject -ProtectedFromAccidentalDeletion:$true -PassThru

#WSUS
$objOU=$objDominio.Create("OrganizationalUnit","ou=WSUS")
$objOU.Put("description","OU Servidor de Actualizaciones")
$objOU.SetInfo()
Get-ADOrganizationalUnit -Identity "OU=WSUS,OU=Servers,OU=WP Computers,$ROOT" | Set-ADObject -ProtectedFromAccidentalDeletion:$true -PassThru


#File Server
$objOU=$objDominio.Create("OrganizationalUnit","ou=File Server")
$objOU.Put("description","OU de Servidor de Ficheros")
$objOU.SetInfo()
Get-ADOrganizationalUnit -Identity "OU=File Server,OU=Servers,OU=WP Computers,$ROOT" | Set-ADObject -ProtectedFromAccidentalDeletion:$true -PassThru

