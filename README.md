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

3) mrkta_mapping_mar24.Rmd
- update location data on `mrkta_gps_tanzania_CLEAN.csv` and `mrkta_generalinfo_tanzania_CLEAN.csv`
- link to tanzania ward data, check distinct rows (ward-village-market names)
- saved as:
  - manual-geomatch: `data/data-cleaning_data/mrkta_gps_manualgeomatchlkp.csv`
  - final INFO: `data/data-cleaning_data/mrkta_generalinfo_tanzania_final.csv`
  - final GPS: `data/data-cleaning_data/mrkta_gps_tanzania_final.csv`
 
 
 
Market B Survey Cleaning
1) mrktb_to_tanzania.R
- subset mrktb_info to tanzania observations: `"data/ecopprmarketscsvs/mrktb_generalinfo.csv"`
- saved as: `"data/tanzania_data/mrktb_generalinfo_tanzania.csv"`


2) mrktb_cleaning_mar24.Rmd
- clean `mrktb_generalinfo_tanzania.csv` data based on market A survey location data 
- NB for observations with duplicate data (i.e. 2 rows with same ward-village-market names but different survey response): calc. mean SR sales.
- geo-link mrktb locations to mrkta locations
- on region-by-region bases verify whether surveys have been appropriately linked.
  - use location matched data, and check date of survey (all surveys for given market completed on the same day)
  - where there are differences between manual location & date data, and the geo-linked location & date data
  - check names across A-linked data, manually cleaned survey data.
  - Update checked market location data accordingly.
- saved as:
  - INFO: `"data/data-cleaning_data/mrktb_generalinfo_tanzania_final.csv"`


Market C Survey Cleaning
1) mrktc_to_tanzania.R
- subset mrktc_info to tanzania observations: `"data/ecopprmarketscsvs/mrktc_generalinfo.csv"`
- saved as: `"data/tanzania_data/mrktc_generalinfo_tanzania.csv"`

2) mrktc_mrktactivities_to_tanzania.R
- subset mrktc_mrktactivities to tanzania observations: `ecopprmarketscsvs/mrktc_mrktactivities.csv`
- saved as: `"data/tanzania_data/mrktc_mrktactivities_tanzania.csv"`

3) mrktc_cleaning_mar24.Rmd
- clean `mrktc_generalinfo_tanzania.csv` data based on market A survey location data 
- crossreference mrktc_tanzania, against final mrkta_gps
- manually update mrktc location data
- saved as:
  - INFO: `"data/data-cleaning_data/mrktc_generalinfo_tanzania_CLEAN.csv"`
  - GPS: `data/data-cleaning_data/mrktc_generalinfo_tanzania_CLEAN1.csv`
  
4) mrktc_mapping_mar24.Rmd
- update location data on `mrktc_gps_tanzania_CLEAN1.csv` 
- link to nearest market using `mrkta_gps_tanzania_final.csv`
- on region-by-region bases verify whether surveys have been appropriately linked.
  - use location matched data, and check date of survey (all surveys for given market completed on the same day)
  - where there are differences between manual/raw location & date data, and the geo-linked location & date data
  - check names across A-linked data, manually cleaned survey data, and raw survey data. 
  - Update checked market location data accordingly.
- saved as:
  - final GPS: `data/data-cleaning_data/mrktc_gps_tanzania_final.csv`
  - final GPS ALL: `data/data-cleaning_data/mrktc_allgps_tanzania_final.csv`
  
5) mrktc_cleaning-info_mar24.Rmd
- Update & clean `mrktc_generalinfo_tanzania_CLEAN.csv` [and ]
- update final location data and cols for inclusion
- saved as: 
  - `mrktc_generalinfo_tanzania_final.csv`
 
 6) mrktc_cleaning-actvty_mar24.Rmd
- Update & clean ``mrktc_mrktactivities_tanzania.csv`
- No location data in this dataframe, 
- Clean and update dataframe to reflect acitivites of interest.
- saved as: 
  - `mrktc_mrktactivities_tanzania_final.csv`