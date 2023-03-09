library(raster)
library(rgdal)
library(sp)

el1 <- raster("/Users/nawafalrumaihi/Documents/SDM py/srtm_59_12/srtm_59_12.tif")
el2 <- raster("/Users/nawafalrumaihi/Documents/SDM py/srtm_60_11/srtm_60_11.tif")
mosee <- mosaic(el1, el2, fun=mean)

### derive topographic products -- slope, aspect & hillshade
# convert lat-long rasters to projected units such as UTM in meters
# utm projection for north boreno
ref <- "+proj=utm +zone=50 +ellps=GRS80 +datum=NAD83 +units=m +no_defs"

# project raster
projected_raster <- projectRaster(mosee, crs = ref)

# calculate slope in degrees
slope_in_degrees <- terrain(projected_raster, opt = "slope", unit = "degrees", neighbors = 8)

# calculate aspect
aspect <- terrain(projected_raster, opt = "aspect", unit = "radians", neighbors = 8)

# resample aspect if necessary
if(!compareRaster(slope_in_degrees, aspect)) {
  aspect_resampled <- resample(aspect, slope_in_degrees)
} else {
  aspect_resampled <- aspect
}

# calculate hillshade
hills <- hillShade(slope_in_degrees, aspect_resampled, angle = 40, direction = 270)

# plot results
par(mfrow = c(2,2))
plot(slope_in_degrees, main = "Slope in degrees")
plot(aspect_resampled, main = "Aspect in radians")
plot(hills, main = "Hillshade")
plotRGB(projected_raster, hills, main = "Hillshaded DEM")
