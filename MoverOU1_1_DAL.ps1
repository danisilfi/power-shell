Import-Module ActiveDirectory

$ROOT="DC=midominio,DC=corp,DC=com"

Write-Host "Moving Oracle OU out of Fault Tolerance OU"
Get-ADOrganizationalUnit -Identity "OU=Oracle Server,OU=Fault Tolerance Servers,OU=Member Server Windows 2008 R2,OU=MIDOMINIO Computers,$ROOT" | Set-ADObject -ProtectedFromAccidentalDeletion:$false -PassThru
Move-ADObject -Identity "OU=Oracle Server,OU=Fault Tolerance Servers,OU=Member Server Windows 2008 R2,OU=MIDOMINIO Computers,$ROOT" -TargetPath "OU=Member Server Windows 2008 R2,OU=MIDOMINIO Computers,$ROOT"
Get-ADOrganizationalUnit -Identity "OU=Oracle Server,OU=Member Server Windows 2008 R2,OU=MIDOMINIO Computers,$ROOT" | Set-ADObject -ProtectedFromAccidentalDeletion:$true -PassThru