### plotting heatmaps

library(data.table)
library(dplyr)
library(plotly)
library(tidyverse)

dat <-fread('data/data_subset.csv') #fread is faster at reading large datasets

# subset eco_actual and eco_total for heat map 1 *not needed?
eco_actual_total <- select(dat, Study_ID, eco_actual_cat, eco_total_cat)


# Load the plotly package
library(plotly)

# read in subset data eco and social
eco <-fread('data/eco.csv') 
social <-fread('data/social.csv') 


# Heatmap eco_actual with eco_total

matrix_eco <-fread('data/matrix_eco.csv') 

data <- as.matrix(matrix_eco)

# basic heatmap
p <- plot_ly(x=colnames(data), y=rownames(data), z = data, type = "heatmap") %>%
  layout(margin = list(l=80))
p


# Heatmap eco_actual with soc_mgmt
matrix_ea_sm <-fread('data/matrix_ea_sm2.csv') 

matrix_ea_sm <- column_to_rownames(matrix_ea_sm, var = "V1")

m_ea_sm <- as.matrix(matrix_ea_sm)

f <- plot_ly(x=colnames(m_ea_sm), y=rownames(m_ea_sm), z = m_ea_sm, type = "heatmap") %>%
  layout(margin = list(l=150))
f


# Heatmap - different method
matrix_ea_sm <-fread('data/matrix_ea_sm2.csv') 

data <- as.matrix(matrix_ea_sm)

p <- plot_ly(x=colnames(data), y=rownames(data), 
             z = data, 
             type = "heatmap", 
             colorscale= "Earth", # can also pick a gradient color with colorRamp(c("red", "yellow"))
             showscale = F) %>%
  layout(margin = list(l=120))
p


# surface plot

data <-fread('data/surfacemap.csv') 

datamatrix <- as.matrix(data) 

p <- plot_ly(x=colnames(data), y=rownames(data), 
             z = datamatrix, 
             type = "surface", 
             colorscale= "Rainbow", 
             showscale = F) %>%
  layout(margin = list(l=120))
p


# surface plot - method2

x <- list(data$eco_actual)

y <- list(data$social_method)

z <- list(data$social_mgmt)


data2 <- list(x, y, z)

data2plot <- plot_ly(x = data2$x, y = data2$y, z = data2$z) %>% add_surface()

data2plot

# surface plot - method1 again

p <- plot_ly(x=data2$x, y=data2$y, 
             z = data2$z, 
             type = "surface", 
             colorscale= "Rainbow", 
             showscale = F)  # %>%
   #layout(margin = list(l=120)) 
p

# add legend - this doesnt work? 
p <- p %>% layout(legend= list(itemsizing='constant'))



# surface plot - method4

p <- plot_ly(x=data$eco_actual, y=data$social_method, 
             z = data$social_mgmt, 
             type = "surface", 
             colorscale= "Rainbow", 
             showscale = F)  %>%
  group_by(data$V1)
#layout(margin = list(l=120)) 
p






# save the widget
# library(htmlwidgets)
# saveWidget(p, file=paste0( getwd(), "/HtmlWidget/plotlyHeatmap1.html")) ## how do I link to this?

