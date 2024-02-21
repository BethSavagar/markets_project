##############################
## HUMAN POPULATION DENSITY ##



library(terra)

# Load the raster data
pop_raster <- rast("data/shapefiles/tza_pd_2020_1km.tif")

# Load the ward polygons
twards_shp

# Use the 'extract' function with fun=sum to calculate total population per ward
pop_per_ward <- extract(pop_raster, twards_shp, fun=sum, na.rm=TRUE)

# Add the result back to the wards data
twards_shp$population = pop_per_ward[,2]

ggplot() +
  # geom_raster(data = as.data.frame(pop_raster, xy = TRUE), aes(x = x, y = y, fill = tza_pd_2020_1km)) +
  geom_sf(data = twards_shp, color = "white", aes(fill = population)) +
  scale_fill_viridis_c()

ggplot() +
  geom_raster(data = as.data.frame(pop_raster, xy = TRUE), aes(x = x, y = y, fill = tza_pd_2020_1km)) +
  # geom_sf(data = tanzania_shape, color = "white", fill = NA) +
  scale_fill_viridis_c()


pop_data <- read_csv("data/shapefiles/tza_pd_2020_1km_ASCII_XYZ.csv")
pop_data_sf <- st_as_sf(pop_data, coords = c("X", "Y"), crs = 4326)

ggplot() +
  geom_sf(data = twards_shp, fill = NA, color = "black") + # Shapefile boundary
  geom_sf(data = pop_data_sf, aes(size = Z), color = "red", alpha = 0.6) + # Population points
  scale_size(range = c(1, 10), name = "Population Size") + # Adjust size scale as needed
  theme_minimal() +
  labs(title = "Population Distribution in Tanzania")
# Spatially join points with wards
sf_use_s2(FALSE)
points_in_wards <- st_join(pop_data_sf, twards_shp)
View(points_in_wards)
