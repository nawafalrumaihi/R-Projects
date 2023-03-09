# CRS of the Raster Data
setwd("/users/nawafalrumaihi/documents/SDM py")
library(raster)
library(sp)

el1 <- raster("/Users/nawafalrumaihi/Documents/SDM py/srtm_59_12/srtm_59_12.tif")
el2 <- raster("/Users/nawafalrumaihi/Documents/SDM py/srtm_60_11/srtm_60_11.tif")

# Merge the two raster objects
j <- merge(el1, el2)

# Save the merged raster object to a file
writeRaster(j, filename="join_el1_el2.tif", format="GTiff", overwrite=TRUE)

# Plot the merged raster
plot(j)

#utm projection for north boreno
ref <- "+proj=utm +zone=50 +ellps=GRS80 +datum=NAD83 +units=m +no_defs"

projectedU <- projectRaster(j, crs = ref)

s <- raster("slp2.tiff")

plot(s)

## utm to lat-long
ref <- "+proj=longlat +datum=WGS84 +no_defs +ellps=WGS84 +towgs84=0,0,0"

projectedL <- projectRaster(s, crs = ref)

projectedL

plot(projectedL)