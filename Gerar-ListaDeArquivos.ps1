. .\env.ps1
$campos = "SCM,FullPath,Name,Version"

echo $campos > ".\arquivos\MDSs.csv"

$mdss = Get-ChildItem -Path $source_mdss -Filter "MDS*.laz" -Recurse -Depth 10000

foreach ($mds in $mdss) {
    [array]$f = $mds.name.split("_")[1],
    $mds.FullName,
    $mds.name,
    $mds.BaseName.split("_")[-1]
    [string]$linha = $f -join ","
    Add-Content -Path ".\arquivos\MDSs.csv" -Value $linha
}

echo $campos > ".\arquivos\MDTs.csv"

$mdts = Get-ChildItem -Path $source_mdss -Filter "MDT*.laz" -Recurse -Depth 10000

foreach ($mdt in $mdts) {
    [array]$f = $mdt.name.split("_")[1],
    $mdt.FullName,
    $mdt.name,
    $mdt.BaseName.split("_")[-1]
    [string]$linha = $f -join ","
    Add-Content -Path ".\arquivos\MDTs.csv" -Value $linha
}
