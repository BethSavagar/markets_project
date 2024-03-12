library(readr)
library(tidyverse)
library(sf)
library(RColorBrewer)


## COLOUR PALETTE ##
custom_theme <- theme_bw() + 
  theme(text = element_text(family = "Times New Roman", size = 10))
theme_set(custom_theme)

tanzania_pal <- rep(brewer.pal(9,"Pastel1"),times=4)
market_pal <- c(brewer.pal(8, "Dark2"), "#FFA500", "#6A3D9A", "#33A02C", "#FFD700", "#1E90FF")

###########


twards_shp <- st_read("data/shapefiles/tzshp_final/twards_final.shp")
mrkta_gps <- read_csv("data/data-cleaning_data/mrkta_gps_tanzania_final.csv")
mrktc_gps <- read_csv("data/data-cleaning_data/mrktc_allgps_tanzania_final.csv")

mrkta_gps %>% colnames()
mrktc_gps %>% colnames()

## MAPDATA ##


mrkta_mapdata <- mrkta_gps %>% 
  mutate(lat = str_split(`gps.coordinates.of.the.market`, "\\s", simplify = TRUE)[, 1],
         long = str_split(`gps.coordinates.of.the.market`, "\\s", simplify = TRUE)[, 2])

# for now ignore rows which have na in lat or long:
mrkta_sf <- st_as_sf(mrkta_mapdata, coords = c("long","lat"),  crs = 4326)

mrktc_mapdata <- mrktc_gps %>% 
  mutate(lat = str_split(`gps.coordinates.of.the.market`, "\\s", simplify = TRUE)[, 1],
         long = str_split(`gps.coordinates.of.the.market`, "\\s", simplify = TRUE)[, 2])

# for now ignore rows which have na in lat or long:
mrktc_sf <- st_as_sf(mrktc_mapdata, coords = c("long","lat"),  crs = 4326)

######

checkA <- mrkta_gps %>% distinct(region, district20, ward, village, market) # 85 unique

checkC <- mrktc_gps %>% distinct(region, district20, ward, village, market) # 84 unique

anti_join(checkA, checkC)

anti_join(checkC, checkA)


mrkta_gps %>%
  distinct(region, district20, ward, village, market) %>%
  left_join(
    mrktc_gps  %>% 
      distinct(region, district20, ward, village, market) %>%
      mutate(df = "c")) %>%
  filter(is.na(df))


## MAP
mrktc_mapdata <- mrktc_gps %>% 
  mutate(lat = str_split(`gps.coordinates.of.the.market`, "\\s", simplify = TRUE)[, 1],
         long = str_split(`gps.coordinates.of.the.market`, "\\s", simplify = TRUE)[, 2])
# arrange(gps.coordinates.of.the.market) %>% 
# filter(!is.na(lat), !is.na(long))

mrktc_sf <- st_as_sf(mrkta_mapdata, coords = c("long","lat"),  crs = 4326) 


ggplot() +
  geom_sf(data = twards_shp %>% filter(Region_N %in% "katavi"), linewidth = 0.1) +
  geom_sf(data = mrkta_sf %>% filter(region %in% "katavi"), aes(col = paste(ward,market,sep="-")), alpha = 0.5, size = 3)+
  geom_sf(data = mrktc_sf %>% filter(region %in% "katavi"), aes(col = paste(ward,market,sep="-")),  shape = 17, size = 1.5)+
  scale_colour_manual(values = rep(market_pal,3))+
  facet_wrap(~ward)+
  coord_sf()+
  labs(col = "Ward of market"
       #title = "Market Survey A-geomatched (circles) and C-linkA (triangles) data",
  )+
  theme(legend.position = "right", legend.box = "horizontal")

ggplot() +
  geom_sf(data = twards_shp %>% filter(Region_N %in% "mtwara"), linewidth = 0.1) +
  geom_sf(data = mrkta_sf %>% filter(region %in% "mtwara"), aes(col = paste(ward,market,sep="-")), alpha = 0.5, size = 3)+
  geom_sf(data = mrktc_sf %>% filter(region %in% "mtwara"), aes(col = paste(ward,market,sep="-")),  shape = 17, size = 1.5)+
  scale_colour_manual(values = rep(market_pal,3))+
  facet_wrap(~ward)+
  coord_sf()+
  labs(col = "Ward of market"
       #title = "Market Survey A-geomatched (circles) and C-linkA (triangles) data",
  )+
  theme(legend.position = "right", legend.box = "horizontal")




