##Tidy Tuesday Submission 2 for Biol 551
##By Evan Rank
##last updated 2021-02-21

##Load libraries
library(here)
library(tidyverse)
library(tidytuesdayR)
library(ghibli)

#Load in data
employ_earn<- tidytuesdayR::tt_load('2021-02-23')

view(employ_earn[["employed"]])
view(employ_earn[["earn"]])

employ_men_women <- employ_earn[["earn"]] %>% 
  filter(complete.cases(.)) %>% 
  filter(sex=="Men" | sex=="Women")
View(employ_men_women)

