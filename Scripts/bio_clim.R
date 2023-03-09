library(dismo)
library(leaflet)

# Load data
setwd("/Users/nawafalrumaihi/Documents/SDM py/2_SDM Data/")
horn<- read.csv("hornbill_my1.csv")
head(horn)
horn1 <- horn[,-1] # first column is not needed

# The geographic extent of Peninsular M'sia
ext <- extent(99, 105, 1.2, 6.7)

all.worldclim <- raster::getData("worldclim", res = 10, var = "bio")
msia.worldclim <- crop(all.worldclim, extent(99, 105, 1.2, 6.7))

# Set up the bounding box of your map
h.extent <- extent(min(horn1$long -1),
                   max(horn1$long + 1),
                   min(horn1$lat - 1),
                   max(horn1$lat + 1))

# Convert h.extent to a numeric vector
h.extent2 <- as.numeric(as.vector(extent(h.extent)))

# Create leaflet map
my_map <- leaflet() %>%
  addTiles() %>%
  setView(101.5, 4.5, zoom = 7) %>%
  addTiles(urlTemplate = "https://server.arcgisonline.com/ArcGIS/rest/services/World_Imagery/MapServer/tile/{z}/{y}/{x}") %>%
  setView(101.5, 4.5, zoom = 7)

# Add markers to the map
my_map <- my_map %>%
  addMarkers(data = horn1, ~long, ~lat, popup = ~paste0("Species: ", horn$species))

# Display map
my_map

## use the bioclim function, which takes your climate layers and the
# long and lat columns (in that order)
h.bc <- bioclim(msia.worldclim, horn1[,c('long', 'lat')])

par(mfrow = c(4,4))
response(h.bc)
par(mfrow = c(1,1))

horn.d <- bioclim(msia.worldclim, horn1[,c('long', 'lat')])
par(mfrow = c(4,4))
response(horn.d)
par(mfrow = c(1,1))

horn.d.pred <- predict(object = horn.d, msia.worldclim)
plot(horn.d.pred, main = "SDM predictions using climate layers")
### add in the same popints from above .cex makes the points smaller
points(horn1[,c('long', 'lat')], pch = 16, cex = 0.5)

### evaluate model performance
## background data (psuedo-absences) needed for this
## determine if the model can differentiate bw the habitat and
# the background

# species presence

head(horn1)

plot(msia.worldclim) # predictors

horn.d <- bioclim(msia.worldclim, horn1[,c('long', 'lat')])
## bioclimatic model

ext <- extent(99, 105, 1.2, 6.7)

backg <- randomPoints(msia.worldclim, n=1000 ,ext=ext, extf = 1.25)
# background/pseudo-absence data

e <- evaluate(horn1, backg, horn.d, msia.worldclim)
# presence, background, model, predictors

e

plot(e, 'ROC')
