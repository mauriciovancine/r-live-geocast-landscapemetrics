### script download fbds ###

## sites
# http://www.fbds.org.br/
# http://geo.fbds.org.br/

# mauricio vancine
# 25-03-2019

# preparate r -------------------------------------------------------------
# memory
rm(list = ls())

# packages
library(rvest)
library(tidyverse)

# directory
di <- "/media/flash/data/fbds_base/01_data"
setwd(di)

# informations ------------------------------------------------------------
# url
url <- "http://geo.fbds.org.br/"
url

# directory
dir.create("00_informations")
setwd("00_informations")

# download
download.file(paste0(url, "Metodologia.pdf"), "Metodologia.pdf")
download.file(paste0(url, "Metadados.pdf"), "Metadados.pdf")
download.file(paste0(url, "TABELA%20CONSOLIDADA.xls"), "tabela_consolidada.xls")

# vectors -----------------------------------------------------------------

# directory
setwd("..")

# state list
states <- xml2::read_html(url) %>% 
  rvest::html_nodes("a") %>% 
  rvest::html_attr("href") %>% 
  tibble::as_tibble() %>% 
  dplyr::slice(., 3:22) %>% 
  dplyr::first() %>% 
  gsub("/", "", .)
states

# download state
for(i in states[18:20]){ # start i - state list
  
  # state directory
  setwd(di)
  dir.create(i)
  setwd(i)
  
  # municipality list
  municipality <- xml2::read_html(paste0(url, i)) %>% 
    rvest::html_nodes("a") %>% 
    rvest::html_attr("href") %>% 
    tibble::as_tibble() %>% 
    dplyr::slice(., -c(1:3)) %>% 
    dplyr::first() %>% 
    grep(".xls", ., value = TRUE, invert = TRUE) %>% 
    sub(paste0("/", i), "", .) %>% 
    gsub("/", "", .)
  municipality
  
  # download municipality
  for(j in municipality){ # start j - municipality list
    
    # municipality directory
    dir.create(j)
    setwd(j)
    
    # map list
    maps <- xml2::read_html(paste0(url, i, "/", j)) %>% 
      rvest::html_nodes("a") %>% 
      rvest::html_attr("href") %>% 
      tibble::as_tibble() %>% 
      dplyr::slice(., -c(1:3)) %>% 
      dplyr::first() %>% 
      sub(paste0("/", i, "/", j), "", .) %>% 
      gsub("/", "", .) 
    maps
    
    # download maps
    for(k in maps){ # start k - maps list
      
      # map directory
      dir.create(k)
      setwd(k)
      
      # file list
      files <- xml2::read_html(paste0(url, i, "/", j, "/", k)) %>% 
        rvest::html_nodes("a") %>% 
        rvest::html_attr("href") %>% 
        grep(paste0(c(".dbf", ".prj", ".shp$", ".shx", ".jpg"), collapse = "|"), ., value = TRUE)
      
      # condition
      if(length(files) == 0){

      } else{
      
      # download
      purrr::map2(paste0(url, files), 
                  paste0(j, "_", stringr::str_split(files, "/", simplify = TRUE)[, 5]), 
                  download.file)
      
      }
      
      # back directory to municipality
      setwd("..")
      
    } # end k - map list
    
    # back directory state
    setwd("..")
    
  } # end j - municipality list
  
  # back directory fbds
  setwd("..")
  
} # end i - state list


# end ---------------------------------------------------------------------
