### plotting heatmaps

library(data.table)
library(dplyr)
library(plotly)

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

m_ea_sm <- as.matrix(matrix_ea_sm)

p <- plot_ly(x=colnames(m_ea_sm), y=rownames(m_ea_sm), z = m_ea_sm, type = "heatmap") %>%
  layout(margin = list(l=150))
p



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

data <-fread('data/data_subset.csv') 

datamatrix <- as.matrix(data) # I think this needs to be a different layout??

p <- plot_ly(x=colnames(data), y=rownames(data), 
             z = data, 
             type = "surface", 
             colorscale= "Rainbow", 
             showscale = F) %>%
  layout(margin = list(l=120))
p

# add legend - this doesnt work? 
p <- p %>% layout(legend= list(itemsizing='constant'))



# save the widget
# library(htmlwidgets)
# saveWidget(p, file=paste0( getwd(), "/HtmlWidget/plotlyHeatmap1.html"))