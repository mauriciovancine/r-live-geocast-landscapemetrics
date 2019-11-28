# Landscape metrics

Repositorio com materiais da live com @mauriciovancine a respeito de  métricas de paisagem com [R](https://cran.r-project.org/), usando o pacote [landscapemetrics](https://cran.r-project.org/web/packages/landscapemetrics/index.html);  

## Roteiro da live:  

1. Apresentação pessoalProfissional:  
  - Formação;  
  - Cursos;  
1. Base teórica:  
  - Ecología de paisagem;  
  - Metricas de paisagem;  
1. Contextualização:  
  - Situação problema;  
  - Especie de sapo;  
    Lago como frag habitat p/ sapo;  
1. Hands-on: landscapemetrics & R:  
  - Pacote;  
  - Quais metricas;  
  - Metricas selecionadas;  
  - Especificações do pacote (raster tem q estar projetado, etc);  
  - Mapa/graficos resultados;  
1. Outros universos/mapas:  
1. Como onde buscar informações:  
  - Livros;  

### Landscapemetrics
O pacote sugere que a paisagem a ser analisada seja um raster em sistema projetado;

O pacote fornece uma função para confirmar se o raster está adequado:  
```r
check_landscape(PARNASO_lu)
```

------------------------------------------------------
 layer      crs      units    class    n_classes   OK 
------- ----------- ------- --------- ----------- ----
   1     projected     m     integer       5       ✔  

   2     projected     m     integer       5       ✔  

   3     projected     m     integer       5       ✔  

   4     projected     m     integer       5       ✔  

   5     projected     m     integer       5       ✔  

------------------------------------------------------  

Com relação às metricas disponíveis:  

```  

-----------------------------------------------------------------------
 metric               name                        type           level 
-------- ------------------------------- ---------------------- -------
  area             patch area             area and edge metric   patch 

  cai            core area index            core area metric     patch 

 circle   related circumscribing circle       shape metric       patch 

 contig         contiguity index              shape metric       patch 

  core              core area               core area metric     patch 

  enn      euclidean nearest neighbor      aggregation metric    patch 
                    distance                                           
-----------------------------------------------------------------------
```  

* [Script com um pre-processamento do raster usado](https://gitlab.com/geocastbrasil/landscapemetrics/blob/master/LandScapeMetrics_Preprocessamento.R);
* [Algumas métricas claculadas](https://gitlab.com/geocastbrasil/landscapemetrics/blob/master/LandScapeMetrics.R)

## Sugestões de artigos  

Sugestão do Israel Schneiberg​:  
* Lenore Fahrig - Effects of habitat fragmentation on biodiversity (2003) doi: 10.1146/annurev.ecolsys.34.011802.132419  
* Miguet P. et al. What determines the spatial extent of landscape effects on species? DOI 10.1007/s10980-015-0314-1  

## Sugestões de pacotes:  
* [multifit](https://cran.r-project.org/web/packages/MultiFit/index.html): para identificação/definição de escala de análise;  
