$csv = ".\arquivos\arquivos_para_processar.csv"
echo "seila"

$process = Import-Csv -Path $csv

ForEach ($p in $process) {
    # Verifica se o arquivo de log existe
    # Caso exista pula para o proximo
    # Caso contrario cria o arquivo de log
    $start = Get-Date
    lasheight -i $item -store_as_extra_bytes -odir ".\norm\" -odix "_norm" -olaz -o "arquivo.laz" >> "..\logs\" 2> "..\logs\" 
    Get-Item $p.MDT_Path
    Get-Item $p.MDS_Path
    $finish = Get-Date
    $time_total = New-TimeSpan -Start $start -End $finish
}

