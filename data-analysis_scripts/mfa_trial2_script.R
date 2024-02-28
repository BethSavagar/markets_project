
library(FactoMineR)
library("factoextra")

mrkts_master_complete <- mrkts_master_noMtwara %>% drop_na()

mrkts_MFA <- mrkts_master_complete %>%
  select(
    # envirchar_s (s)
    humpop_density1km,shppop_10km, gtpop_10km, anmlpop_10km, town.distkm,road.distkm,
    # envirchar_n (n)
    # prod.sys,town.type, road.type,
    
    # mrktchar_s (s)
    num.srvy, num.sales, shp.sales, goat.sales, num.anmls, prop.shp, prop.goat, prop.shpY,
    prop.shpA, prop.goatY, prop.goatA,
    # mrktchar_n (n)
    # main.anml,
    
    # origcatchment_s (s)
    origin.nmvmts, origin.nregs, origin.ndists, origin.nwards, 
    origin.maxdistkm, origin.meandistkm, origin.meddistkm, origin.areakm2,
    
    # destcatchment_s (s)
    dest.nmvmts, dest.nregs, dest.ndists,dest.nwards, 
    dest.maxdistkm, dest.meandistkm, dest.meddistkm, dest.areakm2,
    
    # stkhldrchar_s (s)
    prop.trader, prop.buy,prop.sell,prop.trade,prop.middleman,
    prop.slaughter,prop.food,prop.otheractvty, visits.othermrkt, visits.thismrkt,
    
    # stkhldrchar_n (n)
    # actvty.main,
    
    # stkhldrsellmotiv_s (s)
    starts_with("sellreason."),
    
    # stkhldrsellmotiv_n (n)
    # sellreason.main,
    
    # stkhldrbuymotiv_s (s)
    starts_with("buyreason."),
    
    # stkhldrbuymotiv_n (n)
    # buyreason.main,
    
    # origchar_s (s)
    origin.village,origin.town,origin.market,origin.abattoir,origin.otherplace,
    origin.foot,origin.vehicle,origin.cart,origin.frommrkt,origin.othertransport,origin.unknowntransport,
    
    # origchar_n (n)
    # origin.main, origin.transport.main,
    
    # destchar_s (s)
    dest.village,dest.town,dest.market,dest.abattoir,dest.otherplace,
    dest.foot,dest.vehicle,dest.cart,dest.motorbike,dest.mrktslaughter,dest.atmrkt,
    dest.othertransport,dest.unknowntransport

    # destchar_n (n)
    # dest.main,dest.transport.main
  ) %>%
  # mutate(across(where(is.character), as.factor)) %>%
  select(-c("sellreason.main", "buyreason.main"))
  
colnames(mrkts_MFA) 
# 
# mrktsMFAgroup <- data.frame(
#   group = c(6, 3, 
#             11, 1,
#             8, 8,
#             10, 1,
#             1, 12,
#             1, 12,
#             11, 2,
#             13, 2), 
#   type = c("s","n",
#            "s","n",
#            "s","s",
#            "s","n",
#            "n","s",
#            "n","s",
#            "s","n",
#            "s","n"),
#   name.group = c("enviro_s","enviro_n",
#                  "mrktchar_s","mrktchar_n",
#                  "origarea_s","destarea_s",
#                  "stkhldrchar_s", "stkhldrchar_n",
#                  "stkhldrsellmotiv_n", "stkhldrsellmotiv_s",
#                  "stkhldrbuymotiv_n", "stkhldrbuymotiv_s",
#                  "origchar_s", "origchar_n",
#                  "destchar_s", "destchar_n")
# ) %>%
#   uncount(weights = group, .remove = F) %>%
#   bind_cols(
#     var = colnames(mrkts_MFA)
#   )
# 
# res.mfa <- MFA(mrkts_MFA,
#                group = c(6, 3, 
#                          11, 1,
#                          8, 8,
#                          10, 1,
#                          1, 12,
#                          1, 12,
#                          11, 2,
#                          13, 2), 
#                type = c("s","n",
#                         "s","n",
#                         "s","s",
#                         "s","n",
#                         "n","s",
#                         "n","s",
#                         "s","n",
#                         "s","n"),
#                name.group = c("enviro_s","enviro_n",
#                               "mrktchar_s","mrktchar_n",
#                               "origarea_s","destarea_s",
#                               "stkhldrchar_s", "stkhldrchar_n",
#                               "stkhldrsellmotiv_n", "stkhldrsellmotiv_s",
#                               "stkhldrbuymotiv_n", "stkhldrbuymotiv_s",
#                               "origchar_s", "origchar_n",
#                               "destchar_s", "destchar_n"),
#                num.group.sup = NULL,
#                graph = FALSE)


res.mfa <- MFA(mrkts_MFA,
               group = c(6, # 3,
                         11, # 1,
                         8,
                         8,
                         10, # 1,
                         # 1,
                         12,
                         # 1,
                         12,
                         11, # 2,
                         13 #,2
                         ),  
               # type = c("s",# "n",
               #          "s",# "n",
               #          "s","s",
               #          "s",# "n",
               #          # "n",
               #          "s",
               #          # "n",
               #          "s",
               #          "s", # "n",
               #          "s" #, "n"
               #          ),
               name.group = c("enviro_s",# "enviro_n",
                              "mrktchar_s",# "mrktchar_n",
                              "origarea_s","destarea_s",
                              "stkhldrchar_s", # "stkhldrchar_n",
                              # "stkhldrsellmotiv_n", 
                              "stkhldrsellmotiv_s",
                              # "stkhldrbuymotiv_n", 
                              "stkhldrbuymotiv_s",
                              "origchar_s", # "origchar_n",
                              "destchar_s" #, "destchar_n"
                              ),
               num.group.sup = NULL,
               graph = FALSE)



###############
## RESULTS ##
###############
# library(factoextra)

# mfa result:
print(res.mfa)

## 1) Eigenvalues

# The proportion of variances retained by the different dimensions (axes) 
# can be extracted using the function get_eigenvalue() [factoextra package] 
# as follow:

eig.val <- get_eigenvalue(res.mfa)
head(eig.val)

# eigenvalue variance.percent cumulative.variance.percent
# Dim.1   3.556720        12.914129                    12.91413
# Dim.2   2.873688        10.434100                    23.34823
# Dim.3   2.315033         8.405674                    31.75390
# Dim.4   2.149185         7.803494                    39.55740
# Dim.5   1.797458         6.526407                    46.08380
# Dim.6   1.252474         4.547620                    50.63142

# 12.9% Dim.1, 10.4% Dim.2


## 2) Screeplot

# The function fviz_eig() or fviz_screeplot() [factoextra package] 
# can be used to draw the scree plot:

fviz_screeplot(res.mfa)


## 2) Graph of variables: Groups
# The function get_mfa_var() [in factoextra] is used to extract the 
# results for groups of variables.
# This function returns a list containing the coordinates, 
# the cos2 and the contribution of groups, as well as, the correlation between groups

group <- get_mfa_var(res.mfa, "group")
group

# Coordinates of groups for each dimension
head(group$coord)

# Cos2: quality of representation on the factore map
# how well each group is represented in each dimension
# High cos2 values: Indicate that the principal component(s) effectively capture 
# the essence of the grouped data. 
# These are well-represented in the reduced dimensionality space.
head(group$cos2)

# Contributions to the  dimensions
head(group$contrib)

# PLOT #

# Plot contribution of groups of variables to each dimension / the correlation between groups and dimensions:
fviz_mfa_var(res.mfa, "group")

# stakeholder- buyreason has strong contribution to Dim.1
# stakeholder sell motivation and stakeholder characteristics have moderate contribution to Dim. 1
# origin characteristics (where animals come from) have moderate contribution to Dim.1

# stakeholder characteristics, market characteristics and origin catchment, 
# destination catchement and destination characteristics have highest contribution to Dim.2

# Contribution to the first dimension
fviz_contrib(res.mfa, "group", axes = 1) # red line is equal contrib.
# Contribution to the second dimension
fviz_contrib(res.mfa, "group", axes = 2) # red line is equal contrib.


# 3) Quantitative Variables:
# The function get_mfa_var() [in factoextra] is used to extract the results for quantitative variables. 
# This function returns a list containing the coordinates, the cos2 and the contribution of variables:
quanti.var <- get_mfa_var(res.mfa, "quanti.var")
quanti.var 

# Coordinates
head(quanti.var$coord)
# Cos2: quality on the factore map
head(quanti.var$cos2)
# Contributions to the dimensions
head(quanti.var$contrib)


# Correlation between quantitative variables and dimensions. 
# The R code below plots quantitative variables colored by groups. 
# The argument palette is used to change group colors (see ?ggpubr::ggpar for more information about palette). 
# Supplementary quantitative variables are in dashed arrow and violet color. 
# We use repel = TRUE, to avoid text overlapping.


fviz_mfa_var(res.mfa, "quanti.var", palette = "jco", 
             col.var.sup = "violet", repel = TRUE,
             geom = c("point", "text"), legend = "bottom")

# Briefly, the graph of variables (correlation circle) shows the relationship between variables, 
# the quality of the representation of variables, as well as, the correlation between variables and the dimensions:
# 
# Positive correlated variables are grouped together, whereas negative ones are positioned on opposite sides of the plot origin (opposed quadrants).
# The distance between variable points and the origin measures the quality of the variable on the factor map. 
# Variable points that are away from the origin are well represented on the factor map.
# 
# For a given dimension, the most correlated variables to the dimension are close to the dimension.
# most correlated variables to the first dimension are:??? 
  
  
  
# The contribution of quantitative variables (in %) to the definition of the dimensions can be visualized
# using the function fviz_contrib() [factoextra package]. Variables are colored by groups. 
# The R code below shows the top 20 variable categories contributing to the dimensions:

# Contributions to dimension 1
fviz_contrib(res.mfa, choice = "quanti.var", axes = 1, top = 20,
             palette = "jco")
# Contributions to dimension 2
fviz_contrib(res.mfa, choice = "quanti.var", axes = 2, top = 20,
             palette = "jco")

# The red dashed line on the graph above indicates the expected average value, 
# If the contributions were uniform. 



# The most contributing quantitative variables can be highlighted on the scatter plot using the argument col.var = “contrib”. 
# This produces a gradient colors, which can be customized using the argument gradient.cols.

fviz_mfa_var(res.mfa, "quanti.var", col.var = "contrib", 
             gradient.cols = c("#00AFBB", "#E7B800", "#FC4E07"), 
             col.var.sup = "violet", repel = TRUE,
             geom = c("point", "text"))

# Similarly, you can highlight quantitative variables using their cos2 values representing 
# the quality of representation on the factor map. 
# If a variable is well represented by two dimensions, 
# the sum of the cos2 is closed to one. 
# For some of the row items, more than 2 dimensions might be required to perfectly represent the data.

# Color by cos2 values: quality on the factor map
fviz_mfa_var(res.mfa, col.var = "cos2",
             gradient.cols = c("#00AFBB", "#E7B800", "#FC4E07"), 
             col.var.sup = "violet", repel = TRUE,
             geom = c("point", "text"))

fviz_cos2(res.mfa, choice = "quanti.var", axes = 1)


## INDIVIDUALS ##

ind <- get_mfa_ind(res.mfa)
ind

# To plot individuals, use the function fviz_mfa_ind() [in factoextra]. 
# By default, individuals are colored in blue. 
# However, like variables, it’s also possible to color individuals by their cos2 values:
  
fviz_mfa_ind(res.mfa, col.ind = "cos2", 
               gradient.cols = c("#00AFBB", "#E7B800", "#FC4E07"),
               repel = TRUE)

# Individuals (markets) with similar profiles are close to each other on the factor map
# Markets which are closely aligned (correlated) with dimensions may be explained by the important
# variables contributing to that dimension.



fviz_mfa_axes(res.mfa)


hcpc_result <- HCPC(res.mfa)
# Plot the dendrogram
fviz_dend(hcpc_result, cex = 0.5)

# Plot individuals in the factor map colored by their cluster
fviz_cluster(hcpc_result, geom = "point")



cluster_assignments <- hcpc_result$data.clust$clust

mrkts_master_complete %>% mutate(cluster = cluster_assignments) %>% select(cluster, everything()) %>% View()

# Create a data frame with individual IDs and their corresponding cluster assignments
individuals_clusters <- data.frame(
  individual_id = rownames(cluster_assignments),
  cluster = cluster_assignments
)
