library(raster)
library(sf)
library(dplyr)

# Carregando dados
lu <- stack("./Dados/MATAATLANTICA.tif", bands = seq(1, 33, 5))
names(lu) <- paste0("MA", seq(1985, 2017, 5))

# Carrega PARNASO
PARNASO <- read_sf("./Dados/PARNASO_AI.shp") %>% 
  st_transform(crs = 4326)

# crop to PARNASO
PARNASO_lu <- crop(lu, PARNASO)
PARNASO_lu <- mask(PARNASO_lu, PARNASO)

# Reprojetando para usar no landscape metrics
PARNASO_lu <- projectRaster(PARNASO_lu, crs = "+proj=utm +zone=23 +south +datum=WGS84 +units=m +no_defs")

# Reclassificação
# 0-1 = NA
# 2-5 = 1 Florestas nativas
# 9 = 2 Florestas plantadas
# 10-13 = 3 Vegetacao não florestal
# 14-21 = 4 Agropecuária
# 22-33 = 5 Area não vegetada

reclass <- as.factor(c(1, 5, 1, 
                       8, 9, 2,
                       10, 13, 3,
                       14, 21, 4,
                       22, 33, 5)) 
reclass <- matrix(data = reclass, ncol = 3, nrow = 5, byrow = T)
# corrigindo problemas de reclassificação
for (i in 1:nlayers(PARNASO_lu)){
  # i = 2
  layer <- PARNASO_lu[[i]]
  if (minValue(layer)<3){
    plot(layer==3)
    layer[layer<3] <- 3
  }
  layerReclass <- reclassify(layer, reclass)
  layerReclass
  if (maxValue(layerReclass)>=33){
    layerReclass[layerReclass>=21] <- 5
    layerReclass[layerReclass>13] <- 4
    layerReclass[layerReclass>9] <- 3
    layerReclass[layerReclass>7] <- 2
    layerReclass[layerReclass>5] <- 1
  }
  PARNASO_lu[[i]] <- layerReclass
}

# removendo layer que tem dado problema
PARNASO_lu <- PARNASO_lu[[-c(1,2)]]
#writeRaster(PARNASO_lu, "./Dados/PARNASO_lu_Proj_reclass.tif", overwrite = TRUE)
PARNASO_lu <- stack("./Dados/PARNASO_lu_Proj_reclass.tif")

# writeRaster(PARNASO_lu[[2]], "./Dados/ToDoErosion1.tif", overwrite = T)
# PARNASO_lu[[2]] <- raster("./Dados/ErosionDone1.tif")
# PARNASO_lu[[3]] <- raster("./Dados/ErosionDone2.tif")
# PARNASO_lu[[4]] <- raster("./Dados/ErosionDone3.tif")
# PARNASO_lu[[5]] <- raster("./Dados/ErosionDone4.tif")
# writeRaster(PARNASO_lu, "./Dados/RasterInventado2.tif")
