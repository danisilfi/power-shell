

cls
Write-Host "Enter the name of the user: "
$Name = Read-Host
Write-Host "Enter the full name of the user: "
$Fullname = Read-Host
Write-Host "Enter a description of the user:"
$Description = Read-Host
Write-Host "Enter the password for the user" $Name -foregroundcolor "yellow"
$Password = Read-Host -AsSecureString
Write-Host "Please, enter the password again:"
$Password2 = Read-Host -AsSecureString

$Password_text = [Runtime.InteropServices.Marshal]::PtrToStringAuto([Runtime.InteropServices.Marshal]::SecureStringToBSTR($Password))
$Password2_text = [Runtime.InteropServices.Marshal]::PtrToStringAuto([Runtime.InteropServices.Marshal]::SecureStringToBSTR($Password2))




if ($Password_text -ceq $Password2_text){
Remove-Variable Password_text
Remove-Variable Password2_text
New-LocalUser $Name -Password $Password -FullName $FullName -Description $Description
Add-LocalGroupMember -Group "Administradores" -Member $Name
#Add-LocalGroupMember -Group "Duplicadores" -Member $Name

Write-Host "The user" $Name "has been created"


}
else {

Write-Host "The password entered does not match" -foregroundcolor "red"
}