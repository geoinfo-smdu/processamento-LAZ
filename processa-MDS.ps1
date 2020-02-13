. .\env.ps1
#$csv = ".\arquivos_para_processar.csv"
$csv = ".\arquivos_para_processar_2020_01_17.csv"

$log_csv = ".\logs\registros_processados.csv"
echo "start; SCM; User; Computer; finish; total_time" > $log_csv

$process = Import-Csv -Path $csv

ForEach ($p in $process) {

    $start = Get-Date

    # Verifica se o arquivo de log existe
    # Caso exista pula para o proximo
    if (Test-Path -path $('.\logs\' + $p.SCM)) {
        Write-Host $("Arquivo " + $p.SCM + " existente!")
        Continue
    } else {

        Write-Host $p.SCM

        # Cria o arquivo de log
        echo $null > $('.\logs\' + $p.SCM)
        echo $('Inicio: ' + $start) >> $('.\logs\' + $p.SCM)
        echo $('User: ' + $env:USERNAME) >> $('.\logs\' + $p.SCM)
        echo $('Computer: ' + $env:COMPUTERNAME) >> $('.\logs\' + $p.SCM)

        $mdt_temp = $($env:TEMP + '\' + $p.MDT_Name)
        $mds_temp = $($env:TEMP + '\' + $p.MDS_Name)

        if ($p.MDT_Name.Lenght -gt 0) {
            echo $('Copiando para a pasta ' + $mdt_temp + ' o arquivo ' + $p.MDT_Path) >> $('.\logs\' + $p.SCM)
            Copy-Item -Path $p.MDT_Path -Destination $env:TEMP -Force   
        } else {
            echo $($p.SCM + ' no possui MDT!') >> $('.\logs\' + $p.SCM)
        }

        echo $('Copiando para a pasta ' + $mds_temp + ' o arquivo ' + $p.MDS_Path) >> $('.\logs\' + $p.SCM)
        Copy-Item -Path $p.MDS_Path -Destination $env:TEMP -Force

        echo $('Iniciando LasNoise: ' + $(Get-Date)) >> $('.\logs\' + $p.SCM)
        echo $('"' + $noise_input + '"') >> $('.\logs\' + $p.SCM)

        $noise_output = $('MDS_' + $p.SCM + '_noise.laz')
        & $($lastools_path + "\lasnoise.exe") -cpu64 -i $mds_temp -step_xy 4 -step_z 100 -remove_noise -odir $env:TEMP -o $noise_output -v >> $('.\logs\' + $p.SCM) 2>> $('.\logs\' + $p.SCM + '.erros.log')

        echo $('Iniciando LasHeight: ' + $(Get-Date)) >> $('.\logs\' + $p.SCM)
        $final_output = $($target + '\MDS\MDS_' + $p.SCM + '.laz')
        echo $final_output >> $('.\logs\' + $p.SCM)

        if ($p.MDT_Name.Lenght -gt 0) {
            & $($lastools_path + "\lasheight.exe") -cpu64 -i $($env:TEMP + '\' + $noise_output) -ground_points $mdt_temp -scale_u 1 -change_classification_from_to 10 20 -change_classification_from_to 11 19 -odir ".\MDS_final\" -olaz -o $final_output -v >> $('.\logs\' + $p.SCM) 2>> $('.\logs\' + $p.SCM + '.erros.log')
        } else {
            & $($lastools_path + "\lasheight.exe") -cpu64 -i $($env:TEMP + '\' + $noise_output) -scale_u 1 -change_classification_from_to 10 20 -change_classification_from_to 11 19 -odir ".\MDS_final\" -olaz -o $final_output -v >> $('.\logs\' + $p.SCM) 2>> $('.\logs\' + $p.SCM + '.erros.log')
        }

        echo "Removendo arquivos temporrios ..." >> $('.\logs\' + $p.SCM)
        Remove-Item $($env:TEMP + '\*' + $p.SCM + '*.laz')

        $finish = Get-Date
        $time_total = New-TimeSpan -Start $start -End $finish

        $log_array = @($start, $p.SCM, $env:USERNAME, $env:COMPUTERNAME, $finish, $time_total)

        echo $($log_array -join "; ") >> $log_csv

        echo $('Tempo total gasto (segundos): ' + $time_total) >> $('.\logs\' + $p.SCM)
        echo $('Finalizado as: ' + $finish) >> $('.\logs\' + $p.SCM)
    
        #read-host "Press ENTER to continue.."
    }

}
