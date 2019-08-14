library(raster)
library(tmap)
library(ggplot2)
library(landscapemetrics)
library(dplyr)
library(plyr)

# carregando dados
PARNASO_lu <- stack("./Dados/Raster/PARNASO_lu_Proj_reclass.tif")
# Renomenando layers só apra ter uma referencia
names(PARNASO_lu) <- paste0("UC", seq(1995, 2017, 5))

m <- tm_shape(PARNASO_lu[[c(1, 5)]]) +
  tm_raster(style = "cat", palette = "cat",
            labels = c("Vegetação nativa", 
                       "Floresta plantada", 
                       "Áreas rochosa",
                       "Agricultura",
                       "Área urbana")) + 
  tm_layout(title = "Mapa de uso/cobertura",
          title.position = c("left", "TOP")) +
  tm_facets()
m
#tmap_save(m, "./img/mapas.png")


# landscape metrics
# checking if raster comply with requirements
check_landscape(PARNASO_lu)

# Metricas de paisagem
#pander(lsm_abbreviations_names, "lsmatrics.csv")

# escala paisagem:
# number of patches
lsm_l_np(PARNASO_lu)

# agregation index
lsm_l_ai(PARNASO_lu)


# Class metrics
# total class area
temp <- lsm_c_ca(PARNASO_lu) %>% 
  group_by(layer, class) %>% 
  dplyr::mutate(totalClasse = round((sum(value)/16714), 2)) %>% 
  ungroup()
temp$class <- reorder(temp$class, temp$totalClasse, FUN=sum)
  
temp %>% 
  arrange(layer, desc(totalClasse)) %>% 
  plyr::ddply(c("layer"), transform, label_y=cumsum(totalClasse)-0.5*totalClasse) %>% 
  #mutate(layer = paste0("UC", rep(seq(1995, 2017, 5), 5))) %>% 
  #group_by(layer, class) %>% 
  ggplot(aes(x=factor(layer), y = totalClasse, fill = factor(class))) + 
  geom_bar(stat = "identity", position = "fill") +
  scale_fill_discrete(name = "Área total", labels = c("Área rochosa", "Floresta plantada", "Área urbana", "Agricultura", "Vegetação nativa")) + 
  geom_text(aes(y = label_y, label = totalClasse)) + 
  scale_x_discrete(labels = seq(1995, 2017, 5)) + 
  xlab("Anos") + 
  ylab("Proporção de uso")

# Mean patch area ----
lsm_c_area_mn(PARNASO_lu) %>% 
  ggplot(aes(x=as.factor(layer), y = value, group = as.factor(class), color = as.factor(class))) + geom_line() +
  scale_color_discrete(name = "Classes", labels = c("Vegetação nativa", "Floresta plantada", "Área rochosa", "Agricultura", "Área urbana")) +
  scale_x_discrete(labels = seq(1995, 2017, 5)) + 
  xlab("Anos") + 
  ylab("Tamanho médio dos fragmentos m²") +
  ggtitle("Mean patch area", subtitle = "Tamanho médio dos fragmentos") 

# Mean core area
lsm_c_core_mn(PARNASO_lu) %>%
  #filter( class == 1) %>% 
  ggplot(aes(x=as.factor(layer), value, group = as.factor(class), color = as.factor(class))) + geom_line() + 
  scale_color_discrete(name = "Classes", labels = c("Vegetação nativa", "Floresta plantada", "Área rochosa", "Agricultura", "Área urbana")) +
  scale_x_discrete(labels = seq(1995, 2017, 5)) + 
  xlab("Anos") + 
  ylab("Tamanho médio de \"core area\"") +
  ggtitle("Mean core area", subtitle = "Tamanho médio da área central dos fragmentos")

# Mean core area index
lsm_c_cai_mn(PARNASO_lu) %>% 
  #filter( class == 1) %>% 
  ggplot(aes(x=as.factor(layer), value, group = as.factor(class), color = as.factor(class))) + geom_line() + 
  scale_color_discrete(name = "Classes", labels = c("Vegetação nativa", "Floresta plantada", "Área rochosa", "Agricultura", "Área urbana")) +
  scale_x_discrete(labels = seq(1995, 2017, 5)) + 
  xlab("Anos") + 
  ylab("Core área index") +
  ggtitle("Mean core area index", subtitle = "Core área ponderado pela área (%)") 

# gyration index
lsm_c_gyrate_cv(PARNASO_lu) %>%
  #filter( class == 1) %>% 
  ggplot(aes(x = as.factor(layer), y = value, color = as.factor(class))) + geom_point() + 
  geom_line(aes(group = class)) +
  scale_color_discrete(name = "Classes", labels = c("Vegetação nativa", "Floresta plantada", "Área rochosa", "Agricultura", "Área urbana")) +
  scale_x_discrete(labels = seq(1995, 2017, 5)) + 
  xlab("Anos") + 
  ylab("Gyration") +
  ggtitle("Radius of gyration", subtitle = "Equivalente à contiguidade da paisagem - correlação") 

# patch density
lsm_c_pd(PARNASO_lu) %>%
  filter( class == 1) %>%
  ggplot(aes(x = as.factor(layer), y = value, color = as.factor(class))) + geom_point() + 
  geom_line(aes(group = class)) +
  scale_color_discrete(name = "Classes", labels = c("Vegetação nativa", "Floresta plantada", "Área rochosa", "Agricultura", "Área urbana")) +
  scale_x_discrete(labels = seq(1995, 2017, 5)) + 
  xlab("Anos") + 
  ylab("Densidade de fragmentos") +
  ggtitle("Patch density", subtitle = "Quantidade dde fragmentos por unidade de área")
