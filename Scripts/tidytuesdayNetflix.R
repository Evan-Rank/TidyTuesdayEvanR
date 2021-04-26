##Tidy Tuesday Submission for Biol 551 with Netflix Data
##By Evan Rank
##last updated 2021-02-25

##Load libraries

library(tidyverse)
library(here)
library(tidytuesdayR)

##Read in data
netflix_titles <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2021/2021-04-20/netflix_titles.csv')

##Data wrangling
netflix_movies <- netflix_titles %>% 
  filter(type=="Movie") %>% 
  mutate(duration = str_replace(duration, pattern = " min", replacement = "")) %>% #remove characters so we can plot numeric
  mutate(duration = as.numeric(duration)) #so R recognizes the numeric

##Graph data
ggplot(netflix_movies, aes(x=release_year, y=duration))+
  geom_bin2d(bins=80)+ #bins adjusted for more data to be represented
  theme_bw()+
  labs(title = "Release Year, Duration, and Number of Available Netflix Films",
       subtitle = "as of September 2020",
       x= "Release Year",
       y= "Film Duration",
       fill= "Density of Releases")+
  theme(plot.title = element_text(color="dodgerblue4", size=15, hjust = 0.5), #align center
        plot.subtitle = element_text(color="dodgerblue4", size=12, hjust = 0.5), #trying to theme in blue around the default fill
        axis.title = element_text(color="dodgerblue4", size=15),
        legend.title = element_text(color="dodgerblue4", size=15),
        legend.text=element_text(size=12),
        panel.background=element_rect(fill="steelblue2"),
        panel.border = element_rect(color="royalblue4"))+
  ggsave(here("Output", "NetflixFilmYearVDuration.png"))
  
