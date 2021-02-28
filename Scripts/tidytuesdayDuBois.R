##Tidy Tuesday Submission 1 for Biol 551
##By Evan Rank
##last updated 2021-02-21

##load libraries
library(here)
library(tidyverse)
library(tidytuesdayR)
library(ghibli)

##load in data
DuBois <- tidytuesdayR::tt_load('2021-02-16') ##Data for the week of 2-16 that WEB Dubois used to fight racism with science

View(DuBois)

##DuBois originally presented occupation data in modified pie charts
ggplot(DuBois[["occupation"]], aes(x=Percentage, y=Occupation, fill=Group)) +
  geom_col(width = 0.5, position=position_dodge(0.7))+#I'd like to represent the occupations side by side between races
labs(title="Occupations of White and Colored Populations",
     subtitle="State of Georgia, 1900",
     x="Percentage",
     y="Occupation")+
  theme_classic()+ #removing gridlines to isolate the comparisons and mimic the "feel" of DuBois' graphs
  theme(axis.title=element_text(size = 20, color="#9E8356FF"), #ghibli package "KikiMedium" palette colors
   panel.background=element_rect(fill="#D1B79EFF"),
   legend.text=element_text(size=15, color="#1C1A1FFF"),
   axis.text = element_text(colour = "#9E8356FF"),
   plot.title = element_text(colour = "#1C1A1FFF"),
   plot.subtitle = element_text(colour = "#1C1A1FFF"))+
  scale_fill_manual(values=c("#0E84B4FF", "#B50A2AFF"))
  

