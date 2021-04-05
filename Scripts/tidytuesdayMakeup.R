##Tidy Tuesday submission for Mkaeup Shades
##by Evan Rank
##2021-03-30

##Load libraries
library(tidyverse)
library(here)
library(tidytuesdayR)
library(PNWColors)

##Load in data
#Manual method
sephora <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2021/2021-03-30/sephora.csv')
ulta <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2021/2021-03-30/ulta.csv')
allCategories <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2021/2021-03-30/allCategories.csv')
allShades <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2021/2021-03-30/allShades.csv')
allNumbers <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2021/2021-03-30/allNumbers.csv')

##Plot data to 2d density (stat_density_2d) 
pal <- pnw_palette("Sunset",100) #our palette of choice from PNW

ggplot(allShades, aes(x=sat, y=hue) ) +
  stat_density_2d(aes(fill = ..level..), geom = "polygon")+ #https://www.r-graph-gallery.com/2d-density-plot-with-ggplot2.html#distr
  scale_fill_gradientn(colours = pal)+ 
  labs(title="Makeup Saturation/Hue Distribution in Sephora and Ulta Brands",
       subtitle="Collected January 2021 from the Web",
       x="Saturation", #counts represent each time a vote was cast on an issue
       y="Hue",
       fill="Density")+
  theme_gray()+#Since our axis has a shifted scale, I'd like the defined lines from this theme
  theme(axis.text.y=element_text(color="pink4", size=10),#Skin/Beauty colors in theme
        plot.title = element_text(color="pink4", size=18, hjust = 0.5), #align center
        plot.subtitle = element_text(color="pink4", size=13, hjust = 0.5),
        axis.title = element_text(color="pink4", size=15),
        legend.title = element_text(color="pink4", size=15),
        legend.text=element_text(size=12),
        panel.background=element_rect(fill="peachpuff3"))+
  ggsave(here("Output", "Makeup_Hue_Sat.png"))
