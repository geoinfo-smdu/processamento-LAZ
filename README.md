# Processamento LAZ

Precisamos processar os arquivos de nuvem de pontos de toda a cidade de São Paulo para podermos publica-los. É um conjunto massivo de arquivos e dados dos mais de 1.500 Km2 de área de toda a cidade a uma densidade de 10 ppm2. Precisamos portanto, testar possibilidades e analisar a sua eficiência antes de começarmos um processamento que vai exigir tempo de pessoas e máquinas.

## Objetivo

Nosso objetivo inicial é processar todos os mais de 5500 arquivos de nuvem de pontos para:

* gravar a altura do ponto em relação ao solo, conhecido como _Height Above Ground (HAG)_
* atribuir cor RGB ao ponto

## Metodologia

Temos inicialmente duas possibilidades de fazer isso através de script. Utilizando o [LasTools](https://github.com/LAStools/LAStools) ou o [PDAL](https://github.com/PDAL/PDAL). As duas possibilidades permitem geração de scripts e vamos utilizar nesse projeto uma pasta para testar cada projeto LasTolls e PDAL, onde é possível encontrar cada script específico.

Para fazer essa comparação vamos utilizar 23 arquivos LAZ e TIFF que correspondem aos aerofotolevantamentos de 2017 dos SCMs correspondentes.

A comparação vai ser quantitativa em relação ao tempo gasto no processmento e qualitativa analisando o resultado final do arquivo gerado.

## Conclusões

Assim que executar
