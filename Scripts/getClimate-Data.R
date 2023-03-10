library(raster)

# Set the directory path to store the data
dir_path <- tempdir()

my0 <- getData('GADM', country='MYS', level=0, path=dir_path) #country outline
my1 <- getData('GADM', country='MYS', level=1, path=dir_path) #states included

par(mfrow=c(1,2))
plot(my0, main="Adm. Boundaries Malaysia Level 0")
plot(my1, main="Adm. Boundaries Malaysia Level 1")

## world climate
climate <- getData('worldclim', var='bio', res=2.5, path=dir_path) #resolution 2.5
plot(climate$bio1, main="Annual Mean Temperature")
plot(climate$bio5, main="Maximum Temperature")
