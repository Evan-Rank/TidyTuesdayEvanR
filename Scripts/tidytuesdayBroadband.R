##Tidy Tuesday Submission for Biol 551 with US Broadband Data
##By Evan Rank
##last updated 2021-05-12

#Load libraries

library(here)
library(tidyverse)
library(tidytuesdayR)
library(ggExtra)

#Read in data

broadband <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2021/2021-05-11/broadband.csv')

#Data wrangling

broadband1 <- broadband #new object because i like to leave the original available to reference back

names(broadband1)[3] <- "county_name" #replacing clunky column names
names(broadband1)[4] <- "broadband_availability"
names(broadband1)[5] <- "broadband_usage"


broadband1 <- na_if(broadband1, '-') #annoying "-" characters instead of NAs

broadband_clean <- broadband1 %>% #need the columns as numeric because of the same weird character inclusion
  mutate(broadband_availability = as.numeric(broadband_availability)) %>%
  mutate(broadband_usage = as.numeric(broadband_usage))

#Plot data

p1 <- ggplot(broadband_clean, aes(x=broadband_availability, y=broadband_usage))+ #need to assign object to apply marginal histogram
  geom_point(color="#231335")+
  labs(x="Broadband Availability",
       y="Broadband Usage",
       title="Broadband Availability vs Usage in the United States")+
  theme(plot.title = element_text(hjust=0.5, color="#1f1e29"), #trying to make a purple theme just because
        axis.title = element_text(color="#1f1e29"),
        panel.background = element_rect(fill="#e2e0eb"))

p2 <- ggMarginal(p1, type="histogram", size=10, fill="#74689c")#applies marginal histogram to our previous object

p2
  
ggsave(here("Output", "broadband_us.png"), p2, height = 8, width = 8) #outside of + due to ggExtra issue