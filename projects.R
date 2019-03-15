options(scipen = 100)

list.of.packages <- c("scales", "tidyverse")
new.packages <- list.of.packages[!(list.of.packages %in% installed.packages()[,"Package"])]
if(length(new.packages)) install.packages(new.packages)

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



# Step 2-) Use the geom_point() layer to generate a scatterplot that displays Critic.Score VS VGChartz.Score


# Step 3-) Use the labs layer to provide a Title, a Subtitle and x-y labels to the plot


# Step 4-) Apply our Basic Theme to improve the layout


# OPTIONAL Step 5-) Use the geom_smooth() layer to include a linear trend line


# Result:


# Project 2 - Total videogames sold over time --------------------------------------------------------------------


# Step 1-) Get the Total Sales in 2018 broken down by Month


# Step 2-) Use the geom_line() layer to generate a line plot of Total Sales by Month

# HINT: The group and color parameters can come in handy when using the geom_line() layer


# OPTIONAL Step 3-) Provide a nicer format for the y-axis values (comma separated thousands and € sign)


# Step 4-) Use the labs layer to provide a Title, a Subtitle and x-y labels to the plot


# Step 4-) Apply our Basic Theme to improve the layout


# Result:


# Project 3 - Total videogames sold over time broken down by top 3 Consoles in terms of released games in 2018 --------------------------------------------------------------------


# Step 1-) Get The Top 3 Consoles in terms of amount of released games in 2018 


# Step 2-) Compute the Total Sales of 2018 of the Top 5 Consoles in terms of the amount of released games in 2018 broken down by Console and Relase Month


# Step 3-) Use the geom_line() layer to generate a line plot of Total Sales broken down by Month (in the X axis) and Console (colors and shapes)


# OPTIONAL Step 4-) Provide a nicer format for the y-axis values (comma separated thousands and € sign)


# Step 5-) Use the labs layer to provide a Title, a Subtitle and x-y labels to the plot


# Step 6-) Apply our Basic Theme to improve the layout


# Result:


# Project 4 - Total Sales By top 5 Developers and Top 5 Consoles in terms of Sales --------------------------------------------------------------------

# Step 1-) Get the Top 5 Developers in terms of Total Sales in 2018


# Step 2-) Get the Top 5 Consoles in terms of Total Sales in 2018


# Step 3-) Get the total Sales by Developer and Console of the Top 5 Developers and Consoles


# Step 4-) Use the geom_bar() layer to generate a bar plot of Total Sales broken down by Developer (in the X axis) and Console (colors)


# OPTIONAL Step 5-) Provide a nicer format for the y-axis values (comma separated thousands and € sign)


# Step 6-) Use the labs layer to provide a Title, a Subtitle and x-y labels to the plot



# Step 7-) Apply our Basic Theme to improve the layout


# Result:

