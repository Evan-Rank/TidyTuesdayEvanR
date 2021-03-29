##Tidy Tuesday submission with UN Votes for BIOL551
##by Evan Rank
##2021-03-28

##Load libraries

library(tidyverse)
library(tidytuesdayR)
library(unvotes)#wrapper for datasets
library(here)
library(PNWColors)
##Read in data

unvotes <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2021/2021-03-23/unvotes.csv')
roll_calls <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2021/2021-03-23/roll_calls.csv')
issues <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2021/2021-03-23/issues.csv')

##Data cleaning script from Tidy Tuesdays post, by https://github.com/jthomasmock

votes_issues <- left_join(unvotes, issues) %>% 
  filter(complete.cases(.))  #NA votes and votes that were not on issues are not our subject
view(votes_issues)

pal=pnw_palette("Winter",type = "discrete")
ggplot(votes_issues, aes(y=country, fill=vote))+
  geom_bar()+
  theme_bw()+
  labs(title="Historical UN Vote Counts on Issues by Country",
       subtitle="and Yes/No Proclivity of Countries",
       x="Total Times Voted", #counts represent each time a vote was cast on an issue
       y="Country",
       fill="Vote")+
  theme(axis.text.y=element_text(color="#202F30", size=12),#size adjusted for later height on save
        plot.title = element_text(color="#88a2b9", size=26),
        plot.subtitle = element_text(color="#88a2b9", size=16),
        axis.title = element_text(color="#191B27", size=22),
        legend.title = element_text(color="#202F30", size=22),
        legend.text=element_text(size=20))+ #colors selected from PNW palettes
  scale_fill_manual(values=pal)+
  ggsave(here("Output","UNvotes.png"),
         width = 11, height=21) #large height accounts for many ylabels

