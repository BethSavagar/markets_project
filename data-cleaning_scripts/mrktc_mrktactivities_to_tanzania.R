# mrktc analysis
library(tidyverse)

mrktc_generalinfo <- read_csv("data/tanzania_data/mrktc_generalinfo_tanzania.csv")
mrktc_mrktactivities <- read_csv("ecopprmarketscsvs/mrktc_mrktactivities.csv")

# subset mrktc activities with tanzania only mkts

fids <- mrktc_generalinfo %>%
  pull(fid.see.mrktc.idtable.)%>%
  as.vector()

activities_tanzania <- mrktc_mrktactivities %>%
  filter(`fid (see mrktc_generalinfo)` %in%  fids)

colnames(activities_tanzania)

activities_tanzania_clean <- activities_tanzania %>% 
  rename_with(tolower) %>% # all lowercase
  rename_with(~gsub("[[:punct:]]", " ", .x)) %>% # replace all punctuation with space " " 
  rename_with(~gsub("\\s+", ".", .x)) # replace any space with single "."
# rename specific columns...
# rename(
#
# )

# write.csv(activities_tanzania_clean, "data/tanzania_data/mrktc_mrktactivities_tanzania.csv", row.names = F)
