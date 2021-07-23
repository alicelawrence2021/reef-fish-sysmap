## create gobal map with study locations and pop density
setwd('/home/lucy')
library(data.table)
install.packages('ggspatial')
library(ggspatial)
install.packages('rnaturalearthdata')
library(rnaturalearthdata)
install.packages('rnaturalearth')
library(rnaturalearth)
install.packages('maps')
library(maps) # this is the map you use
install.packages('tidyverse')
library(tidyverse)
install.packages('ggplot2')
library(ggplot2)
install.packages('sp')
library(sp)
library(dplyr)
theme_set(theme_classic())
theme_set(theme_bw())

dat <- fread('reef-fish-sysmap/data/data_subset.csv') %>% # fread is faster at reading in large datasets than read.csv
dplyr::rename("Country" = "Location_country") 
pop <- fread('reef-fish-sysmap/data/API_SP.POP.TOTL_DS2_en_csv_v2_2627335.csv', skip=2, header=T) %>% # fread is faster at reading in large datasets than read.csv 
  select('Country Name', '2020') %>%
  dplyr::rename("Country" = "Country Name") %>%
  dplyr::rename("popdens_2020" = "2020") 

  
#rnaturalearth map
sp::plot(ne_countries(type ="map_unit", scale = 50))
## download world map dataset
mp<-map_data('world')  # get world map


# merge pop denisty and reeffish_sysmap data
datpop <- merge(dat, pop, by = "Country")
datpop 


# global map 
g.map<-ggplot() +
  geom_polygon( data=mp, aes(x=long, y=lat,  group=group),
                color= "transparent", fill="grey90", size=0.7)+#,fill=first_year_recorded
  geom_point(data = dat, size=4, alpha = .5, shape = 21, col = 'black',
             aes(long, lat)) + #fill=
 # geom_text_repel(data = , aes(long, lat, label=)) + ## add labels
  coord_quickmap() + 
  theme_bw() +
  labs(x = '', y = '',  title='Geographic spread of studies') #+ #,fill = '',
 # scale_color_distiller(type='seq', palette='RdYlGn', na.value = 'grey90', guide='colourbar') 
 # lims(y = c(-70, 80)) + ## tropical latitude ylims, can remove if countries go outside these values
 # theme(legend.position = 'bottom',
 #       legend.key.width = unit(2, 'cm'),
 #      axis.text = element_blank(),
  #      plot.title=element_text(face = 'bold', size=11, hjust=0.5),
  #      plot.margin=unit(c(1, 0.1, 0.1, 0.1), 'cm'))
