knitr::opts_knit$set(root.dir = "C:/Users/Administrator/Documents/MASTER2/LGEO2250_GNSS_temp/GNSS")

library(dplyr)
library(sf)
library(gstat)
library(ggplot2)
library(tmap)
library(lubridate)

# load data

# Corrected data
transect_corr <- read.csv("transect_REL_corrected.csv")
pp_corr <- read.csv("points_precis_REL_corrected.csv")

# Non-corrected data
transect_noncorr <- read.csv("transect_REL.csv")
pp_noncorr <- read.csv("points_precis_REL.csv")

# Fix name
pp_corr[18, 7] <- "bord resto U"
pp_corr[18, 1] <- 19

# Remove duplicate
pp_corr <- pp_corr %>% filter(Name != "bord resto U")

# Convert name to integer
pp_corr$Name <- as.integer(pp_corr$Name)
pp_noncorr$Name <- as.integer(pp_noncorr$Name)

# add column
pp_corr$type <- "point"
transect_corr$type <- "transect"

pp_noncorr$type <- "point"
transect_noncorr$type <- "transect"

# merge 
data_corr <- bind_rows(pp_corr, transect_corr)
data_noncorr <- bind_rows(pp_noncorr, transect_noncorr)

# convert to SF
sf_corr <- st_as_sf(data_corr,
                    coords = c("Longitude", "Latitude"),
                    crs = 4258,
                    remove = FALSE) %>%
  st_transform(31370)

sf_noncorr <- st_as_sf(data_noncorr,
                       coords = c("Longitude", "Latitude"),
                       crs = 4258,
                       remove = FALSE) %>%
  st_transform(31370)

# ADD THIS (needed for your extra code)
sf_datacorr_lambert <- sf_corr
sf_data_lambert <- sf_noncorr

# types
points_corr <- sf_corr %>% filter(type == "point")
transect_corr <- sf_corr %>% filter(type == "transect")

points_noncorr <- sf_noncorr %>% filter(type == "point")
transect_noncorr <- sf_noncorr %>% filter(type == "transect")

#same grid
sf_all <- rbind(sf_corr, sf_noncorr)

bbox <- st_bbox(sf_all)

margin <- 0.5

grid <- expand.grid(
  x = seq(bbox["xmin"] - margin, bbox["xmax"] + margin, length.out = 150),
  y = seq(bbox["ymin"] - margin, bbox["ymax"] + margin, length.out = 150)
)

grid_sf <- st_as_sf(grid, coords = c("x", "y"), crs = 31370)

# IDW
idw_corr <- idw(Ellipsoidal.height ~ 1, sf_corr, grid_sf, idp = 15)
idw_noncorr <- idw(Ellipsoidal.height ~ 1, sf_noncorr, grid_sf, idp = 15)

# convert to dataframe
df_corr <- cbind(st_coordinates(idw_corr), altitude = idw_corr$var1.pred) %>%
  as.data.frame()

df_noncorr <- cbind(st_coordinates(idw_noncorr), altitude = idw_noncorr$var1.pred) %>%
  as.data.frame()

# difference between corr and not corr
df_diff <- df_corr
df_diff$diff <- df_corr$altitude - df_noncorr$altitude

# plot corrected
ggplot() +
  geom_raster(data = df_corr, aes(X, Y, fill = altitude)) +
  geom_contour(data = df_corr, aes(X, Y, z = altitude), bins = 10, color = "black", linewidth = 0.2) +
  geom_sf(data = points_corr, aes(color = "Points ponctuels"), size = 0.8) +
  geom_sf(data = transect_corr, aes(color = "Transect"), size = 0.8) +
  geom_sf_text(data = points_corr, aes(label = Name), size = 3, vjust = -0.5, color = "red") +
  scale_fill_viridis_c(name = "Altitude (m)") +
  scale_color_manual(
    name = "Type de points",
    values = c("Points ponctuels" = "red", "Transect" = "black")
  ) +
  labs(title = "Interpolation IDW (données corrigées)") +
  coord_sf() +
  theme_minimal()

# plot not corrected
ggplot() +
  geom_raster(data = df_noncorr, aes(X, Y, fill = altitude)) +
  geom_contour(data = df_noncorr, aes(X, Y, z = altitude), bins = 10, color = "black", linewidth = 0.2) +
  geom_sf(data = points_noncorr, aes(color = "Points ponctuels"), size = 0.8) +
  geom_sf(data = transect_noncorr, aes(color = "Transect"), size = 0.8) +
  geom_sf_text(data = points_noncorr, aes(label = Name), size = 3, vjust = -0.5, color = "red") +
  scale_fill_viridis_c(name = "Altitude (m)") +
  scale_color_manual(
    name = "Type de points",
    values = c("Points ponctuels" = "red", "Transect" = "black")
  ) +
  labs(title = "Interpolation IDW (données non corrigées)") +
  coord_sf() +
  theme_minimal()

# plot difference 
ggplot() +
  geom_tile(data = df_diff, aes(X, Y, fill = diff)) +
  geom_contour(data = df_diff, aes(X, Y, z = diff), bins = 10, color = "black", linewidth = 0.2, alpha = 0.6) +
  scale_fill_gradient2(
    name = "Difference (m)",
    low = "blue",
    mid = "white",
    high = "red",
    midpoint = 0
  ) +
  labs(title = "Différence d'altitude : corrigé - non corrigé") +
  coord_sf(crs = 31370) +   
  theme_minimal()

# tmap
bb <- sf::st_bbox(sf_data_lambert)

bb_expand <- bb
bb_expand["xmin"] <- bb["xmin"] - 0.20 * (bb["xmax"] - bb["xmin"])
bb_expand["xmax"] <- bb["xmax"] + 0.20 * (bb["xmax"] - bb["xmin"])
bb_expand["ymin"] <- bb["ymin"] - 0.20 * (bb["ymax"] - bb["ymin"])
bb_expand["ymax"] <- bb["ymax"] + 0.20 * (bb["ymax"] - bb["ymin"])

points <- tm_basemap("CartoDB.PositronNoLabels") + 
  tm_shape(sf_data_lambert, bbox = bb_expand) +
  tm_symbols(fill = "steelblue", shape = 16, size = 0.5, fill_alpha = 0.9) +
  tm_layout(
    legend.show = FALSE,
    frame = TRUE
  ) +
  tm_title(
    text = "Points non corrigés",
    size = 1.8,
    color = "steelblue",
    fontface = "bold")

points_corr <- tm_basemap("CartoDB.PositronNoLabels") + 
  tm_shape(sf_datacorr_lambert, bbox = bb_expand) + 
  tm_symbols(fill = "steelblue", shape = 16, size = 0.5, fill_alpha = 0.9) +
  tm_layout(
    legend.show       = FALSE,
    frame             = TRUE)+
  tm_title(text  = "Points corrigés", 
           size   = 1.8,
           color  = "steelblue",
           fontface = "bold")

tmap_arrange(points, points_corr, ncol=2)

# profil
transect_lavoisier <- sf_datacorr_lambert %>%
  filter(grepl("transect escalier lavoisier", Description, ignore.case = TRUE))

transect_lavoisier <- transect_lavoisier %>%
  mutate(distance_m = 0) 

coords <- st_coordinates(transect_lavoisier)
for(i in 2:nrow(transect_lavoisier)) {
  dist <- st_distance(
    st_point(coords[i-1,]), 
    st_point(coords[i,]), 
    by_element = TRUE)
  transect_lavoisier$distance_m[i] <- transect_lavoisier$distance_m[i-1] + as.numeric(dist)
}

profil_zoom <- ggplot(transect_lavoisier, aes(x = distance_m/1000, y = Ellipsoidal.height)) +
  geom_line(color = "darkblue", linewidth = 2, alpha = 0.9) +
  geom_point(color = "darkred", size = 4, alpha = 1) +
  geom_ribbon(aes(ymin = 173, ymax = Ellipsoidal.height),
              fill = "lightblue", alpha = 0.4) +
  scale_y_continuous(
    limits = c(173, 178),
    breaks = seq(173, 178, by = 0.5),
    expand = expansion(mult = c(0, 0.02))) +
  labs(
    title = "Profil altimétrique - Transect Escalier Lavoisier ",
    x = "Distance le long du transect (km)",
    y = "Altitude ellipsoïdale (m)") +
  theme_minimal() +
  theme(
    plot.title = element_text(size = 14),
    axis.title = element_text(size = 12),
    panel.grid.minor = element_blank(),
    panel.grid.major.y = element_line(color = "gray90", linewidth = 0.5))

print(profil_zoom)

# statistic analyse
summary(df_corr$altitude)
summary(df_noncorr$altitude)
summary(df_diff$diff)

cat("Altitude corrigée - min :", min(df_corr$altitude), "max :", max(df_corr$altitude), "\n")
cat("Altitude non corrigée - min :", min(df_noncorr$altitude), "max :", max(df_noncorr$altitude), "\n")
cat("Différence - min :", min(df_diff$diff), "max :", max(df_diff$diff), "\n")

mean_diff <- mean(df_diff$diff)
sd_diff <- sd(df_diff$diff)

cat("Différence moyenne (corr - non corr) :", mean_diff, "m\n")
cat("Ecart-type des différences :", sd_diff, "m\n")

rmse <- sqrt(mean((df_diff$diff)^2))
cat("RMSE :", rmse, "m\n")

sf_corr <- sf_corr %>% arrange(Name)
sf_noncorr <- sf_noncorr %>% arrange(Name)

point_diff <- sf_corr$Ellipsoidal.height - sf_noncorr$Ellipsoidal.height

cat("Différence moyenne (points) :", mean(point_diff), "m\n")
cat("RMSE (points) :", sqrt(mean(point_diff^2)), "m\n")