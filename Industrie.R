---
title: "OECD Industrieanteil"
author: "JV"
date: "17 5 2023"
output: html_document
---

```{r}
library(tidyverse)
library(OECD)

#https://fgeerolf.com/data/oecd/SNA_TABLE6A_SNA93.html

df <- get_dataset("SNA_TABLE6A",
                  filter= "..VTOT+VC") %>% 
  filter(MEASURE=="C",
         TRANSACT=="B1GA") 

df1 <-  df %>% select(LOCATION, Time, ACTIVITY, ObsValue) %>%
  group_by(LOCATION, Time) %>% 
  pivot_wider(names_from = ACTIVITY, values_from=ObsValue) %>% 
  mutate(Industrieanteil = as.numeric(VC)/as.numeric(VTOT),
         Time=as.numeric(Time))



# "C" Current prices


df1 <- df1 %>% filter(Time==2021) %>% 
  arrange(Industrieanteil) %>%
  ungroup() %>% 
  mutate(Position=row_number())

df1%>% #filter(Time==2021) %>% 
  #arrange(Industrieanteil) %>%
  #ungroup() %>% 
  #mutate(Position=row_number()) %>% 
  ggplot(aes (x=reorder(LOCATION, Position), Industrieanteil))+
  geom_bar(stat="identity", fill="blue")+
  labs(x="Staaten")+
  theme_light()

  df1 %>% #filter(LOCATION=="DEU") %>%
  filter(Time > 1999) %>% 
  ggplot(aes(Time, Industrieanteil))+
  geom_point()+
  geom_line()+
  geom_smooth(method="glm")+
  theme_light()+
  facet_wrap(~LOCATION, scales="free_y")
```

