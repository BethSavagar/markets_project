# markets_project



# Data Cleaning: (120424)

1) tanzania_mapping.Rmd
- .Rmd file cleaning tanzania shapefiles at region, district and ward level
- Final shapefiles saved in: `data/shapefiles/tzshp_final/`
- tregs = humdata 
- tdists = NBS data from 2019
- twards = humdata with update NBS district names
- Used for mapping market locations from survey A and survey C


Market A Survey Cleaning
1) mrkta_to_tanzania.R
- subset mrkta_info to tanzania observations: `"data/ecopprmarketscsvs/mrkta_generalinfo.csv"`
- saved as: `"data/tanzania_data/mrkta_generalinfo_tanzania.csv"`

2) mrkta_cleaning_mar24.Rmd
- clean `mrkta_generalinfo_tanzania.csv` data
- saved as: 
  - INFO: `data/data-cleaning_data/mrkta_generalinfo_tanzania_CLEAN.csv`
  - GPS: `data/data-cleaning_data/mrkta_gps_tanzania_CLEAN.csv`

2) mrkta_mapping_mar24.Rmd
- update location data on `mrkta_gps_tanzania_CLEAN.csv` and `mrkta_generalinfo_tanzania_CLEAN.csv`
- link to tanzania ward data, check distinct rows (ward-village-market names)
- saved as:
  - manual-geomatch: `data/data-cleaning_data/mrkta_gps_manualgeomatchlkp.csv`
  - final INFO: `data/data-cleaning_data/mrkta_generalinfo_tanzania_final.csv`
  - final GPS: `data/data-cleaning_data/mrkta_gps_tanzania_final.csv`
 
 
 
Market B Survey Cleaning
1) mrktb_to_tanzania.R
- subset mrkta_info to tanzania observations: `"data/ecopprmarketscsvs/mrktb_generalinfo.csv"`
- saved as: `"data/tanzania_data/mrktb_generalinfo_tanzania.csv"`



Market C Survey Cleaning
1) mrktc_to_tanzania.R
- subset mrktc_info to tanzania observations: `"data/ecopprmarketscsvs/mrktc_generalinfo.csv"`
- saved as: `"data/tanzania_data/mrktc_generalinfo_tanzania.csv"`

2) mrktc_mrktactivities_to_tanzania.R
- subset mrktc_mrktactivities to tanzania observations: `ecopprmarketscsvs/mrktc_mrktactivities.csv`
- saved as: `"data/tanzania_data/mrktc_mrktactivities_tanzania.csv"`



