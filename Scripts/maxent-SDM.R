library(raster)
library(rgdal)
library(dismo)

setwd("/Users/nawafalrumaihi/Documents/SDM py/2_SDM Data/bioclim")

dataFiles <- Sys.glob("*.tif")

dataFiles # list of predictors
stck <- stack() # empty raster stack for storing raster layers

for(i in seq_len(NROW(dataFiles))){
  tempraster <- raster(dataFiles[i])
  stck <- stack(stck, tempraster)
}

stck # raster predictors as a stackplot

plot(stck, 2)

# presence data

horn <- read.csv("hornbill_my1 copy.csv")
head(horn)
horn1 <- horn[,-1] # first column is not needed

points(horn1, col='blue')

group <- kfold(horn1, 5) # split the data into 5 portions
# build and test models on all 5 data splits
pres_train <- horn1[group !=1,]
pres_test <- horn1[group == 1,]

###

xm <- maxent(stck, pres_train) # implement maxent on the presence-only data
plot(xm)