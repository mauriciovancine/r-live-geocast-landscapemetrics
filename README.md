# Landscape metrics

Repositorio para trabalhar o tema de métricas de paisagem com [LS Metrics]() e [landscapemetrics]();



### Landscapemetrics
O pacote sogere que a paisagem a ser analisada seja um raster em sistema projetado;

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
