# Script usuarios por Grupo
$usuarios = Get-LocalGroup
echo "--------"
foreach ($item in $usuarios) 
            { 
            Get-LocalGroupMember -Name $item.Name
            echo $usuario
            echo "##### Grupo ^"
            echo $item.Name
            echo "#####"

}