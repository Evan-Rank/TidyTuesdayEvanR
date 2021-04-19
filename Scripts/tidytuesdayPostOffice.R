##Tidy Tuesday Submission for Biol 551 with Post Office Data
##By Evan Rank
##last updated 2021-02-21

library(tidyverse)
library(here)
library(tidytuesdayR)
library(maps)
library(mapdata)
library(mapproj)
library(PNWColors)

post_offices <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2021/2021-04-13/post_offices.csv')

post_established <- post_offices %>% 
  filter(gnis_state != "AK") %>% #narrowing down to contiguous states
  filter(gnis_state != "HI") %>% 
  filter(established >1638) #clean up some unlikely values in dates

usa <- map_data("usa") #load map for stacking points
head(usa)

pal=pnw_palette("Sunset",100) #color palette of choice out of PNWColors

ggplot()+
  geom_polygon(data=usa, aes(x=long, y=lat,group=group), color="grey")+ #draw map of USA
  theme_void()+ #don't need lat/long lines
  coord_map("mercator")+ #mercator projection, default limits
  labs(title = "Density of US Post Offices",
       subtitle = "All Current and Historical Locations in the Contiguous States",
       x="",
       y="")+#empty labels, just need the shape of the map
  theme(plot.title = element_text(hjust = 0.5, color = "grey12"),
        plot.subtitle = element_text(hjust=0.5, color = "grey11"))+
  geom_point(data = post_established, size = 0.5, #adds a point at each site
             aes(x = longitude,
                 y = latitude,
                 color = established))+
  labs(color= "Year Established")+
  scale_color_gradientn(colors=pal)+
  ggsave(here("Output","PostOffice.png"),
         width = 15, height = 12)
