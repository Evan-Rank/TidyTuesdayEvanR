##Tidy Tuesday Submission for Biol 551
##By Evan Rank
##last updated 2021-02-21

##Load libraries

library(here)
library(tidyverse)
library(tidytuesdayR)
library(lubridate)

##Read in data

games <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2021/2021-03-16/games.csv')

view(games)

##Data wrangling

#Filter out genre
FPSgames <- games %>% #I'm personally curious in the playerbase history for multiplayer first person shooter games, which I have personal experience with.
  filter(gamename %in% c("Counter-Strike: Global Offensive", #top FPS games on Steam
                         "PLAYERUNKNOWN'S BATTLEGROUNDS", "Apex Legends", 
                         "Team Fortress 2", "Tom Clancy's Rainbow Six Siege", "Destiny 2", "PAYDAY 2"))

view(FPSgames)

#Summarise average players by year

FPSmean <- FPSgames %>% 
  group_by(gamename, year) %>% 
  summarise_at(vars(avg),
               list(mean_monthly_players=mean))
view(FPSmean)

##Plot average number of players over time for each game

ggplot(FPSmean, aes(x=year, y=mean_monthly_players, color=gamename, label=gamename))+
  geom_line(size=2)+ #Line plot shows the relative trajectory of each game, thicker lines easier on the eyes
  labs(title="Average Current Players of FPS Games",
       subtitle = "by Active Players on the Steam PC Gaming Platform",
       x="Year",
       y="Mean Active Players",
       color="Game Name")+
  theme_dark()+ #theme with dark gridlines
  theme(axis.title=element_text(color="grey10"), #applying built in colors in R for our theme.
        legend.text=element_text(color="grey10"),
        axis.text = element_text(color = "grey10"),
        plot.title = element_text(size=20),
        panel.background=element_rect(fill="grey96"))+
  scale_color_viridis_d()+#colorblind-friendly color scale
  ggsave(here("Output","FPSgames.png"),
         width = 9, height = 6)
  