# Processamento LAZ

Precisamos processar os arquivos de nuvem de pontos de toda a cidade de São Paulo para podermos publica-los. É um conjunto massivo de arquivos e dados dos mais de 1.500 Km2 de área de toda a cidade a uma densidade de 10 ppm2. Precisamos portanto, testar possibilidades e analisar a sua eficiência antes de começarmos um processamento que vai exigir tempo de pessoas e máquinas.

## Objetivo

Nosso objetivo inicial é processar todos os mais de 5500 arquivos de nuvem de pontos para:

* gravar a altura do ponto em relação ao solo, conhecido como _Height Above Ground (HAG)_
* atribuir cor RGB ao ponto

## Metodologia

Temos inicialmente duas possibilidades de fazer isso através de script. Utilizando o [LasTools](https://github.com/LAStools/LAStools) ou o [PDAL](https://github.com/PDAL/PDAL). As duas possibilidades permitem geração de scripts e vamos utilizar nesse projeto uma pasta para testar cada projeto LasTolls e PDAL, onde é possível encontrar cada script específico.

Para programar e executar o scrip iremos utilizar o PowerShell que tem se mostrado bastante interessante e sobretudo nos dá a possibilidade de executar tarefas em paralelo e em diversaa máquinas de maneira relativamente simples.

## Passo-a-passo

É importante nesse passo a passo levarmos em conta algumas primissas:

* Diversos processamentos podem estar ocorrendo ao mesmo tempo em máquinas distintas na mesma rede
* Os resultados precisam ser autitáveis
* Os processo deve prever pausas e recomeços do ponto onde parou

Portanto temos a seguinte lista seriada em um processo prévio:

* Criar uma lista de arquivos MDS Laz
* Criar uma lista de arquivos MDT Laz

E cada um dos processos:

* Iterar sobre os arquivos Laz, contidos na lista
* Executar os processamentos para cada arquivo
* Gravar log
* Excluir arquivo processado da lista

## Escalabilidade

Vamos sempre começar os testes com apenas um arquivo, depois para alguns, depois para muitos para então quantificar e estimar as capacidades necessárias para então executar o script e processar os resultados finais.