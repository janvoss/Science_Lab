

library(tidyverse)

#Quelle: https://epi.yale.edu/downloads, 18.10.23

df <- read.csv("epi2022results05302022.csv") %>% 
  select(code, iso, country, region, EPI.new)


head(df)

library(ggrepel)

p <- df %>% 
ggplot(aes(x=region, y=EPI.new, label=country, fill=region))+
  geom_boxplot()+
  geom_point(alpha=.3)+
  geom_text_repel()+
  theme_light()+
  labs(title="Environmental Performance Index nach Region, 2022",
    x="Region",
    y="Environmental Performance Index",
    fill="Region",
    caption= "Darstellung: Jan S. Voßwinkel, Daten: epi.yale.edu, Datenabruf: 18.10.2023")
  
p
  
library(plotly)
  
p1 <-ggplotly(p) 
  
p1  
