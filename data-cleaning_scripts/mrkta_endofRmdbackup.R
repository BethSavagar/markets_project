





```{r maps}




# Consistency of manual, and geomatched region-ward data?

# number of rows where district and ward name are matched exactly
mrkta_geomatch_gps %>% 
  filter(district.region.name == region.name.geomatch, 
         ward.name == ward.name.geomatch) %>%
  nrow()

mrkta_geomatch_gps %>% 
  filter(district.region.name != region.name.geomatch | ward.name != ward.name.geomatch) %>%
  nrow()


```


```{r }
# Plot locations of markets when more than one market per ward:

mrkta_geomatch_mapdata <- mrkta_geomatch_gps %>% 
  mutate(lat = str_split(`gps.coordinates.of.the.market`, "\\s", simplify = TRUE)[, 1],
         long = str_split(`gps.coordinates.of.the.market`, "\\s", simplify = TRUE)[, 2]) %>% 
  filter(!is.na(lat), !is.na(long))

# check how many rows were lost when removing obs with  missing gps:
# nrow(mrkta_gps); nrow(mrkta_mapdata)

# for now ignore rows which have na in lat or long:
mrkta_geomatch_sf <- st_as_sf(mrkta_geomatch_mapdata, coords = c("long","lat"),  crs = 4326)

map_plots <- list()
for (i in 1:length(multimrkt_geomatch$region.district.ward.geomatch)) {
  
  region_i <- multimrkt_geomatch$region.name.geomatch[i]
  
  map_plots[[i]] <- ggplot() +
    # geom_sf(data = tregs_shp %>% filter(region.name %in% region_i), fill = "grey", alpha = 0.5, linewidth = 0.1) +
    geom_sf(data = twards_shp %>% filter(region.name %in% region_i,
                                         ward.name %in% multimrkt_geomatch$ward.name.geomatch), fill = "grey", alpha = 0.5, linewidth = 0.1) +
    geom_sf(data = mrkta_geomatch_sf %>% filter(region.name.geomatch %in% region_i, 
                                                region.district.ward.geomatch %in% multimrkt_geomatch$region.district.ward.geomatch),
            aes(col = region.district.ward.geomatch), size = 1.5)+
    scale_colour_manual(values = market_pal)+
    coord_sf()+
    facet_wrap(~ward.name.geomatch)+
    labs(title = "Market survey A: survey locations (coloured by stringRegion)", 
         fill = "Tanzania region",
         col = "Market region")+
    theme(legend.position = "right", legend.box = "horizontal")
  
}

map_plots[[1]]; map_plots[[2]]; map_plots[[3]]; map_plots[[4]]; map_plots[[5]]; 

```


```{r matchCheck}

######################
# Check Matched Data #
######################

# Check consistency between manually cleaned mrkta location data and geomatched location data:

# number of rows where district and ward name are matched exactly
mrkta_geomatch_gps %>% 
  filter(district.region.name == region.name.geomatch, 
         ward.name == ward.name.geomatch) %>%
  nrow()

mrkta_geomatch_gps %>% 
  filter(district.region.name != region.name.geomatch | ward.name != ward.name.geomatch) %>%
  nrow()


# review rows where region-ward data are not matched 
mrkta_geomatch_gps %>% 
  filter(district.region.name != region.name.geomatch | ward.name != ward.name.geomatch) %>%
  select(fid,
         district.region.name, # manual
         region.name.geomatch, # matched
         district.name.geomatch, # matched
         ward.name,
         ward.name.geomatch, # manual
         village, 
         market.name.corrected
  ) %>%
  mutate(region.ward.manual = paste(district.region.name, ward.name, sep="-"),
         region.ward.geomatch = paste(region.name.geomatch, ward.name.geomatch, sep="-")) %>%
  View()


# Check original mrkta data:

## LOOKUPS ##
mrkta_lkpregion <- read_csv(here("data/ecopprmarketscsvs/mrkta_lkpregion.csv"))
mrkta_lkpward <- read_csv(here("data/ecopprmarketscsvs/mrkta_lkpward.csv"))

mrkta_raw <- read_csv(file = here("data/tanzania_data/mrkta_generalinfo_tanzania.csv")) %>%
  left_join(mrkta_lkpward %>% select(Code, "ward.name" = "Description"),
            by = c(`ward.see.mrkta.lkpward.` = "Code")) %>%
  left_join(mrkta_lkpregion %>% select(Code, "district.region.name" = "Description"),
            by = c(`district.region.see.mrkta.lkpregion.` = "Code")) %>%
  select("fid" = "fid.see.mrkta.idtable.",
         "district.region.name.raw" = "district.region.name",
         "ward.name.raw" = "ward.name",
         "village.raw" = "village", 
         "market.name.raw" = "name.of.market"
  )


# review rows where region-ward data are not matched 
mrkta_geomatch_gps %>% 
  filter(district.region.name != region.name.geomatch | ward.name != ward.name.geomatch) %>%
  select(fid,
         district.region.name, # manual
         ward.name, # manual
         village, # manual
         market.name.corrected, # manual
         region.name.geomatch, # matched
         district.name.geomatch, # matched
         ward.name.geomatch # matched
  ) %>%
  left_join(mrkta_raw, by = "fid") %>% 
  mutate(region.ward.manual = paste(district.region.name, ward.name, village, market.name.corrected, sep="-"),
         region.ward.geomatch = paste(region.name.geomatch, district.name.geomatch, ward.name.geomatch, sep="-"),
         region.ward.raw = paste(district.region.name.raw, ward.name.raw, village.raw, market.name.raw, sep="-")
  ) %>%
  View()


# how to clean data based on matches / mismatches of raw data with shapefile?
# string match any part of manual / raw data with geomatch data
# any way to check locations of remaining points with discrepencies?

# Check if ward or market or village raw/manual is contained within district or ward geomatched data


```


```{r mrkta_geomatched_MAP}
##################################
# Geo-matched Map, check Regions #
##################################
mrkta_geomatched_mapdata <- mrkta_geomatched_gps %>% 
  mutate(lat = str_split(`gps.coordinates.of.the.market`, "\\s", simplify = TRUE)[, 1],
         long = str_split(`gps.coordinates.of.the.market`, "\\s", simplify = TRUE)[, 2]) %>% 
  filter(!is.na(lat), !is.na(long))
mrkta_geomatched_sf <- st_as_sf(mrkta_geomatched_mapdata, coords = c("long","lat"),  crs = 4326)

## Region: id regions with surveyed markets:
regions <- mrktAtwards_match_sf %>% distinct(region.name.twards) %>% pull()
Regions <- str_to_title(regions)

mrktAtwards_match_map <- ggplot() +
  geom_sf(data = tregs_shp, fill = NA, linewidth = 0.1) +
  
  geom_sf(data = twards_shp %>% filter(Region_Nam %in% regions), aes(fill = Region_Nam), linewidth = 0.1) +
  scale_fill_manual(values=alpha(tanzania_pal,0.7), guide = "none")+
  # geom_sf(data = mrkta_sf, aes(col = district.region.name), alpha = 0.5, size = 3)+
  geom_sf(data = mrktAtwards_match_sf, aes(col = region.name.twards), alpha = 0.5, size = 3)+
  geom_sf(data = mrktAtwards_match_sf, aes(col = district.region.name.A),  shape = 17, size = 1.5)+
  scale_colour_manual(values = rep(market_pal,9))+
  coord_sf()+
  labs(title = "Market Survey A locations: ward-matched (circle) and manual (triangle)",
       fill = "Tanzania region",
       col = "Market region")+
  #theme(legend.position = "none") #+
  theme(legend.position = "bottom", legend.box = "horizontal")

mrktAtwards_match_map

#########################################
# Geo-matched Map, check Ward by Region #
#########################################

## Region: id wards with surveyed markets:
wardlist <- mrktAtwards_match %>% select(ward.name.twards) %>% distinct() %>% pull()

map_plots <- list()
for (i in 1:length(regions)) {
  
  Region_i <- Regions[i]
  region_i <- regions[i]
  
  # For region (i) id wards with surveyed markets according to geo-matched data 
  wardlist_i <- mrktAtwards_match %>% 
    filter(region.name.twards == region_i) %>% 
    select(ward.name.twards) %>% 
    distinct() %>% pull()
  
  map_plots[[i]] <- ggplot() +
    geom_sf(data = twards_shp %>% filter(Region_Nam == region_i), fill = NA) +
    geom_sf(data = twards_shp %>% filter(Region_Nam == region_i,
                                         Ward_Name %in% wardlist_i), 
            aes(fill = Ward_Name, alpha = 0.5)) +
    
    geom_sf(data = mrktAtwards_match_sf %>% filter(region.name.twards == region_i),
            aes(col = ward.name.twards),  alpha = 0.5, size = 3)+
    # geom_sf(data = mrktAtwards_match_sf %>% filter(region.name.twards == region_i), 
    #         aes(col = ward.name.A),  shape = 17, size = 1.5)+
    # geom_sf(data = mrktCtwards_match_sf%>% filter(region.name.twards == region_i), aes(col = ward.name.3A),  shape = 17, size = 1.5)+
    scale_fill_manual(values = rep(market_pal,10))+    
    scale_colour_manual(values = rep(market_pal,10))+
    facet_wrap(~region.name.twards)+
    coord_sf()+
    theme(legend.position = "bottom")
}

map_plots[[1]]; map_plots[[2]]; map_plots[[3]]; map_plots[[4]]; map_plots[[5]]; map_plots[[6]]; map_plots[[7]];
map_plots[[8]]; map_plots[[9]]; map_plots[[10]]; map_plots[[11]]; map_plots[[12]]; map_plots[[13]]
```
