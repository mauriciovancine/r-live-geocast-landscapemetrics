# -------------------------------------------------------------------------
# landscape metrics
# mauricio vancine
# mauricio.vancine@gmail.com
# 13-08-2019
# -------------------------------------------------------------------------

# preparate r -------------------------------------------------------------
# memory
rm(list = ls())

# packages
library(fasterize)
library(landscapemetrics)
library(landscapetools)
library(raster)
library(rgdal)
library(sf)
library(tidyverse)

# directory
path <- "./"
setwd(path)
getwd()
dir()

# import data -------------------------------------------------------------
# import
rc <- sf::read_sf("./dados/vector/rio_claro/SP_3543907_USO.shp")
rc

ggplot() + 
  geom_sf(data = rc, aes(fill = CLASSE_USO), color = NA) + 
  scale_fill_manual(values = c("blue", "orange", "gray", "forestgreen", "green")) +
  labs(x = "Longitude", y = "Latitude", fill = "Classes") +
  theme_bw()

# create number coloumn
rc <- rc %>% 
  dplyr::mutate(class = seq(5))
sf::st_drop_geometry(rc)

# rasterize ---------------------------------------------------------------
# create raster
ra <- fasterize::raster(rc, res = 30)
ra

# rasterize
rc_raster <- fasterize::fasterize(sf = rc, raster = ra, field = "class")
rc_raster

# plot
fasterize::plot(rc_raster)

# ggplot
ggplot() +
  geom_raster(data = raster::rasterToPoints(rc_raster) %>% tibble::as_tibble(), 
              aes(x, y, fill = factor(layer))) +
  scale_fill_manual(values = c("blue", "orange", "gray", "forestgreen", "green")) +
  labs(x = "Longitude", y = "Latitude", fill = "Classes") +
  theme_bw()

# landscapetools
landscapetools::show_landscape(rc_raster, discrete = TRUE)

# buffers -----------------------------------------------------------------
po <- sf::read_sf("./dados/vector/rio_claro/pontos_amostragem.shp")
po

bu <- sf::st_buffer(po, 2000)
bu

# ggplot
ggplot() +
  geom_raster(data = raster::rasterToPoints(rc_raster) %>% tibble::as_tibble(), 
              aes(x, y, fill = factor(layer))) +
  geom_sf(data = bu, fill = NA, color = "black", size = 1) +
  scale_fill_manual(values = c("blue", "orange", "gray", "forestgreen", "green")) +
  labs(x = "Longitude", y = "Latitude", fill = "Classes") +
  theme_bw()

# crop and mask landscapes ------------------------------------------------
# select buffers
bu01 <- dplyr::filter(bu, id == 1)
bu01
plot(bu01[1])

bu02 <- dplyr::filter(bu, id == 2)
bu02
plot(bu02[1])

# crop and mask landscapes
la01 <- rc_raster %>% 
  raster::crop(bu01) %>% 
  raster::mask(bu01)
la01
la01 %>% plot

la02 <- rc_raster %>% 
  raster::crop(bu02) %>% 
  raster::mask(bu02)
la02
la02 %>% plot

# check rasters -----------------------------------------------------------
landscapemetrics::check_landscape(la01)
landscapemetrics::check_landscape(la02)

# list metrics ------------------------------------------------------------
# all
all_metrics <- landscapemetrics::list_lsm()
all_metrics

# patch metrics
patch_metrics <- landscapemetrics::list_lsm() %>%
  dplyr::filter(level == "patch")
patch_metrics

# class metrics
class_metrics <- landscapemetrics::list_lsm() %>%
  dplyr::filter(level == "class")
class_metrics

# landscape metrics
landscape_metrics <- landscapemetrics::list_lsm() %>%
  dplyr::filter(level == "landscape")
landscape_metrics

# metrics -----------------------------------------------------------------
# calculate for example the Euclidean nearest-neighbor distance on patch level
landscapemetrics::lsm_p_enn(la01)

# calculate the total area and total class edge length
landscapemetrics::lsm_l_ta(la01)
landscapemetrics::lsm_c_te(la01)

# calculate all metrics on patch level
lsm_patch <- landscapemetrics::calculate_lsm(rc_raster, level = "patch", progress = TRUE)
lsm_patch

# Plot landscape + landscape with labeled patches
landscapemetrics::show_patches(rc_raster, class = 4, labels = FALSE)
landscapemetrics::show_cores(rc_raster, class = 4, labels = FALSE)
landscapemetrics::show_lsm(rc_raster, what = "lsm_p_area", class = 4, label_lsm = TRUE, labels = FALSE)

# Spatialize landscape metric values
lsm_p_area_raster <- landscapemetrics::spatialize_lsm(rc_raster$layer, what = "lsm_p_cai", progress = TRUE)
lsm_p_area_raster
lsm_p_area_raster[[1]]
landscapetools::show_landscape(lsm_p_area_raster[[1]]$lsm_p_cai)

# end ---------------------------------------------------------------------