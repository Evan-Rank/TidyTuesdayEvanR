##Tidy Tuesday Submission 2 for Biol 551
##By Evan Rank
##last updated 2021-02-21

##Load libraries
library(here)
library(tidyverse)
library(tidytuesdayR)

#Load in data
employ_earn<- tidytuesdayR::tt_load('2021-02-23')

#View data to find our angle for presentation
view(employ_earn[["employed"]])
view(employ_earn[["earn"]])

#Plotting the median earnings of men and women by year.

earn_men_women <- employ_earn[["earn"]] %>% #Taking from earnings data
  filter(complete.cases(.)) %>% 
  filter(sex=="Men" | sex=="Women")
  ggplot(earn_men_women, aes(x=year, y=median_weekly_earn, color=sex))+
    geom_point(stat= 'identity', position=position_dodge(1))+ #Men and women side by side
    scale_x_continuous(breaks=c(2010,2011,2012,2013,2014,2015,2016,2017,2018,2019,2020))+ #Marking the x axis by year
  labs(title="Median Earnings for Men and Women by Year",
       x="Year",
       y="Median Weekly Earnings",
       color="Sex")+
    theme(axis.title=element_text(color="ivory4"), #applying built in colors in R for our theme.
          legend.text=element_text(color="gray27"),
          axis.text = element_text(color = "lightyellow4"),
          plot.title = element_text(color = "grey12"))+
    scale_color_viridis_d()+ #Colorblind friendly color scale for data
    ggsave(here("Output","EarningsMenWomen.png"),
           width = 9, height = 6)
