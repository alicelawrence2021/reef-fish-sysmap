## read in data
setwd('/home/lucy')
library(data.table)
dat <- fread('ReefFish_data_simple_fromexcel.csv') # fread is faster at reading in large datasets than read.csv
