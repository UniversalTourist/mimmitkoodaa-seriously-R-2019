options(scipen = 100)

library(tidyverse)
library(data.table)
library(magrittr)
library(scales)
library(outliers)

Dataset <- fread('./data/worked_data.csv',stringsAsFactors = T)
Dataset[,Release.Date.Pretty :=as.Date(fasttime::fastPOSIXct(x = Release.Date.Pretty))]
Dataset[,Last.Update.Pretty :=as.Date(fasttime::fastPOSIXct(x = Last.Update.Pretty))]


# Basic Theme -------------------------------------------------------------


BasicTheme <- theme(
  panel.grid.major = element_line(colour = "#F0F0F0"),
  panel.grid.minor = element_line(colour = "#F0F0F0"),
  panel.background = element_blank(),
  text = element_text(
    size = 10 ,
    face = "bold" ,
    vjust = 0.5 ,
    hjust = 1
  ),
  axis.line = element_line(colour = "black")
)

# Ex 1 --------------------------------------------------------------------

# Total videogames sold over time

Dataset %<>% mutate(
  Release.Month = lubridate::month(Release.Date.Pretty , label = T),
  Release.Year = year(Release.Date.Pretty)
)

SalesByMonth <- Dataset %>% filter(Release.Year == 2018) %>%
  group_by(Release.Month) %>%
  summarise(Sales = sum(Total.Sales , na.rm = T))


ggplot(data = SalesByMonth , aes(x = as.ordered(Release.Month) , y = Sales)) +
  geom_line(group = 1 , color = '#ffa500') +
  scale_y_continuous(labels = scales::dollar_format(suffix = "€", prefix = "")) +
  labs(
    title = "Total Videogames Sales By Month",
    subtitle = "Videogames released during 2018",
    x = "Month",
    y = "Sales"
  )  +
  BasicTheme


# Ex 2 --------------------------------------------------------------------

# Total videogames sold over time broken down by top 5 grossing Developers


Top10Devs <- Dataset %>% filter(Release.Year == 2018) %>%
  group_by(Developer) %>%
  summarise(Releases = n()) %>%
  arrange(-Releases) %>%
  head(5) %>%
  select(Developer) %>%
  unique()

SalesByMonthAndDev <-
  Dataset %>% filter(Release.Year == 2018, Developer %in% Top10Devs$Developer) %>%
  group_by(Release.Month , Developer) %>%
  summarise(Sales = sum(Total.Sales , na.rm = T))


ggplot(data = SalesByMonthAndDev , aes(x = as.ordered(Release.Month) , y = Sales , color = Developer , group = Developer)) +
  geom_line() +
  scale_y_continuous(labels = scales::dollar_format(suffix = "€", prefix = "")) +
  labs(
    title = "Total Videogames Sales By Month broken down by top 5 grossing Developers",
    subtitle = "Videogames released during 2018",
    x = "Month",
    y = "Sales"
  ) +
  BasicTheme

# Ex 3 --------------------------------------------------------------------

# Scatterplot: Total Sales VS User Score

OutlierlessDS <- Dataset[!outliers::scores(Dataset$Total.Sales[!is.na(Dataset$Total.Sales)], type="chisq", prob=0.99),]
OutlierlessDS <- OutlierlessDS[!outliers::scores(OutlierlessDS$User.Score[!is.na(OutlierlessDS$User.Score)], type="chisq", prob=0.99),]

ggplot(data = OutlierlessDS , aes(x = Total.Sales , y = User.Score)) +
  geom_point() +
  geom_smooth() +
  scale_x_continuous(labels = scales::dollar_format(suffix = "€", prefix = "")) +
  labs(
    title = "Total Videogames Sales VS User Scores",
    x = "Total Sales (€)",
    y = "Users Scores (0-10)"
  ) +
  BasicTheme
