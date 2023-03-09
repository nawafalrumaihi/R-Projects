setwd("/users/nawafalrumaihi/documents/SDM py")

library(raster)
library(rgdal)

tmean <- raster("/Users/nawafalrumaihi/Documents/SDM py/2_SDM Data/tempAvg.tif")
tmean

tmin <- raster("/Users/nawafalrumaihi/Documents/SDM py/2_SDM Data/tempMin.tif")
tmin

alt <- raster("/Users/nawafalrumaihi/Documents/SDM py/2_SDM Data/altitude.tif")
alt

plot(alt)

#####
setwd("/Users/nawafalrumaihi/Documents/SDM py/MYS_adm/states/P_malaysia")

pm=readOGR(".", "P_malaysia")

plot(pm, add=T)

altc <- crop(alt, pm)
plot(altc)

####
setwd("/Users/nawafalrumaihi/Documents/SDM py/2_SDM Data")

land <- raster("landuse1.tif")

plot(land)

alt

landC <- resample(land, alt, method="bilinear")

landC

plot(landC)

####

library(spocc)

## get data for multiple species from multiple DBs
spp <- c("Rhinoplax vigil", "Buceros rhinoceros", "Anthracoceros malayanus")

dat <- occ(query = spp, from ='gbif', gbifopts = list(hasCoordinate=TRUE))
dat

library(mapr)

map_leaflet(dat) #leaflet based interactive map

library(ggplot2)
library(ggmap)
library(mapview)

