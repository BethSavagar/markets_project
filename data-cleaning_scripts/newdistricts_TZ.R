tdists_shp <- st_read(here("data/shapefiles/tza_admbnda_adm2_20181019.shp"))

ggplot() +
  geom_sf(data = tdists_shp, aes(fill = ADM1_EN)) +
  scale_fill_manual(values=tanzania_pal)+  
  geom_sf(data = tdists2_shp, fill = NA, col = "blue", linetype = "dashed") +
  scale_color_discrete(guide = "none")+
  geom_sf_text(data = tdists_shp, aes(label = ADM2_EN), size = 2)+
  labs(title = "Tanzania map of Regions (colour) and Ward (boundary)", fill = "Regions")

sf_use_s2(FALSE)
twards2_shp <- st_join(twards_shp, 
        tdists2_shp %>% select(Region20 = Region_Nam, NewDist20))
