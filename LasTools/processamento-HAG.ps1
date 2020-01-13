$inputFolder = "\\SMDUGBC88\Compartilhada\Silvio\AltaEdif\MDS-LAZ\norm\*.laz"
foreach ($item in (Get-Item $inputFolder).FullName) {
    #lasheight -i $item  -store_as_extra_bytes -odir "\\SMDUGBC88\Compartilhada\Silvio\AltaEdif\MDS-LAZ\norm\" -odix "_norm" -olaz
    echo "*************************************************"
    echo $item
    echo "**************************************************"
    lasinfo $item >> "\\SMDUGBC88\Compartilhada\Silvio\AltaEdif\MDS-LAZ\norm\resulados.json"
}