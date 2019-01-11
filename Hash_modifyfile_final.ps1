Param(
	[string]$Path
	
)
Get-FileHash -Algorithm SHA512 $Path  | Format-List -property Hash  > .\Hash.txt


$bytes  = [System.IO.File]::ReadAllBytes($Path)
$offset = 00

$bytes[$offset]   = 0xFF
$bytes[$offset+1] = 0xFF
$bytes[$offset+2] = 0xFF

$Path2 = $Path+".new"

[System.IO.File]::WriteAllBytes($Path2, $bytes)
Get-FileHash -Algorithm SHA512 $Path2 | Format-List -property Hash  > .\newhash.txt
