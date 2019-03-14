options(scipen = 100)

library(tidyverse)
library(scales)
source("Preprocess.R")

# First of all, check out the Dataframe!
head(df, 10)

# Base Theme (it will prettify the plots) ---------------------------------

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

# Project 1 - Critics Score VS User Score --------------------------------------------------------------------

# Step 1-) Filter out missing values in the Critic.Score and VGChartz.Score variables

ScatterOutlierlessDS <-
  df %>% filter(!is.na(df$Critic.Score), !is.na(df$VGChartz.Score))

# Step 2-) Use the geom_point() layer to generate a scatterplot that displays Critic.Score VS VGChartz.Score

Plot <-
  ggplot(data = ScatterOutlierlessDS , aes(x = Critic.Score , y = VGChartz.Score)) +
  geom_point()

# Step 3-) Use the labs layer to provide a Title, a Subtitle and x-y labels to the plot

Plot <- Plot +
  labs(title = "Total Videogames Sales VS User Scores",
       x = "Critic Scores (0-10)",
       y = "VG Chartz Scores (0-10)")

# Step 4-) Apply our Basic Theme to improve the layout

Plot <- Plot +
  BasicTheme

# BONUS Step 5-) Use the geom_smooth() layer to include a linear trend line

Plot <- Plot + geom_smooth(method = "lm")

# Result:

Plot

# Project 2 - Total videogames sold over time --------------------------------------------------------------------


# Step 1-) Get the Total Sales in 2018 broken down by Month

SalesByMonth <- df %>% filter(Release.Year == 2018) %>%
  group_by(Release.Month) %>%
  summarise(Sales = sum(Total.Sales , na.rm = TRUE))

# Step 2-) Use the geom_line() layer to generate a line plot of Total Sales by Month

# HINT: The group and color parameters can come in handy when using the geom_line() layer

Plot <-
  ggplot(data = SalesByMonth , aes(x = Release.Month , y = Sales)) +
  geom_line(group = 1 , color = '#ffa500')

# Step 3-) Provide a nicer format for the y-axis values (comma separated thousands and € sign)

Plot <- Plot +
  scale_y_continuous(labels = scales::number_format(big.mark = ","))

# Step 4-) Use the labs layer to provide a Title, a Subtitle and x-y labels to the plot

Plot <- Plot + labs(
  title = "Total Videogames Sales By Month",
  subtitle = "Videogames released during 2018",
  x = "Month",
  y = "Total Sales"
)  +
  BasicTheme

# Step 4-) Apply our Basic Theme to improve the layout

Plot <- Plot +
  BasicTheme

# BONUS Step 5-) Use the geom_smooth() layer to include a linear trend line

Plot <- Plot + geom_smooth(method = "lm")

# Result:

Plot


# Project 3 - Total videogames sold over time broken down by top 3 Consoles in terms of released games in 2018 --------------------------------------------------------------------


# Step 1-) Get The Top 3 Consoles in terms of amount of released games in 2018 

Top5Consoles <- df %>% filter(Release.Year == 2018) %>%
  group_by(Console) %>%
  summarise(Releases = n()) %>%
  arrange(-Releases) %>%
  head(3) %>%
  select(Console)

# Step 2-) Compute the Total Sales of 2018 of the Top 5 Consoles in terms of the amount of released games in 2018 broken down by Console and Relase Month

SalesByMonthAndDev <-
  df %>% filter(Release.Year == 2018, Console %in% Top5Consoles$Console) %>%
  group_by(Release.Month , Console) %>%
  summarise(Sales = sum(Total.Sales , na.rm = TRUE))

# Step 3-) Use the geom_line() layer to generate a line plot of Total Sales broken down by Month (in the X axis) and Console (colors and shapes)

Plot <- ggplot(data = SalesByMonthAndDev ,
       aes(
         x = Release.Month ,
         y = Sales ,
         color = Console ,
         group = Console,
         linetype = Console
       )) +
  geom_line()

# Step 4-) Provide a nicer format for the y-axis values (comma separated thousands and € sign)

Plot <- Plot + scale_y_continuous(labels = scales::number_format(big.mark = ","))

# Step 5-) Use the labs layer to provide a Title, a Subtitle and x-y labels to the plot

Plot <- Plot +  labs(
    title = "Total Videogames Sales By Month broken down by top 5 game releaser Consoles",
    subtitle = "Videogames released during 2018",
    x = "Month",
    y = "Total Sales"
  )

# Step 6-) Apply our Basic Theme to improve the layout

Plot <-  Plot +
  BasicTheme

# Result:

Plot


# Project 4 - Total Sales By top 5 Developers and Top 5 Consoles in terms of Sales --------------------------------------------------------------------

# Step 1-) Get the Top 5 Developers in terms of Total Sales in 2018

Top5Developers <- df %>% filter(Release.Year == 2018) %>%
  group_by(Developer) %>%
  summarise(TotalSales = sum(Total.Sales, na.rm = TRUE)) %>%
  arrange(-TotalSales) %>%
  head(5) %>%
  select(Developer)

# Step 2-) Get the Top 5 Consoles in terms of Total Sales in 2018

Top5Consoles <- df %>% filter(Release.Year == 2018) %>%
  group_by(Console) %>%
  summarise(TotalSales = sum(Total.Sales, na.rm = TRUE)) %>%
  arrange(-TotalSales) %>%
  head(5) %>%
  select(Console)

# Step 3-) Get the total Sales by Developer and Console of the Top 5 Developers and Consoles

SalesByDeveloper <- df %>% 
  filter(Developer %in% Top5Developers$Developer , Console %in% Top5Consoles$Console) %>% 
  group_by(Developer,Console) %>%
  summarise("Total Sales" = sum(Total.Sales, na.rm = TRUE)) %>% 
  arrange(-`Total Sales`)

# Step 4-) Use the geom_bar() layer to generate a bar plot of Total Sales broken down by Developer (in the X axis) and Console (colors)

Plot <- ggplot(data = SalesByDeveloper ,
               aes(
                 x = Developer ,
                 y = `Total Sales` ,
                 fill = Console
               )) +
  geom_bar(stat = "identity" , position = 'dodge')

# Step 5-) Provide a nicer format for the y-axis values (comma separated thousands and € sign)

Plot <- Plot + scale_y_continuous(labels = scales::number_format(big.mark = ","))

# Step 6-) Use the labs layer to provide a Title, a Subtitle and x-y labels to the plot

Plot <- Plot +
  labs(title = "Total Videogames Sales by Top 5 Developers and Top 5 Consoles in 2018",
       x = "Developer",
       y = "Total Sales")

# Step 7-) Apply our Basic Theme to improve the layout

Plot <-  Plot +
  BasicTheme

# Result:

Plot
