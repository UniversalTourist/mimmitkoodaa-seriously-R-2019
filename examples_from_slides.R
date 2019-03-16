# install.packages('tidyverse')

library(tidyverse)
df <- read_csv('data/worked_data.csv')

head(df)
summary(df)
str(df)
glimpse(df)

df_example_1 <- df %>%
  group_by(Game) %>%
  summarise(total_sales_ever = sum(Total.Sales, na.rm = TRUE)) %>%
  arrange(desc(total_sales_ever)) %>%
  head(10)
  
df_example_2 <- df %>%
  group_by(Console) %>%
  summarise(total_games_released = n_distinct(Game)) %>%
  arrange(desc(total_games_released))


df_example_3 <- df %>%
  group_by(Game) %>%
  summarise(total_shipped_ever = sum(Total.Shipped, na.rm = TRUE)) %>%
  arrange(desc(total_shipped_ever)) %>%
  head(10)

# mutate examples start here

df_example_4 <- df %>%
  filter(Release.Date.Pretty > as.Date('1990-01-01')) %>%
  mutate(age_in_days = Sys.Date() - Release.Date.Pretty) %>%
  arrange(desc(Total.Sales)) %>%
  select(Game, Total.Sales, age_in_days)


df_example_5 <- df %>%
  mutate(percentage_North_America_from_total = NA.Sales/Total.Sales) %>%
  arrange(desc(percentage_North_America_from_total)) %>%
  filter(percentage_North_America_from_total < 1) %>%
  select(Game, Console, percentage_North_America_from_total, Total.Sales)


df_example_6 <- df %>%
  mutate(days_since_last_update_of_data = Sys.Date() - Last.Update.Pretty) %>%
  arrange(days_since_last_update_of_data) %>%
  select(Game, days_since_last_update_of_data, Last.Update.Pretty)
df_example_6

df_example_7 <- df %>%
  filter(is.na(Critic.Score) == FALSE,
         is.na(User.Score) == FALSE) %>%
  mutate(difference_in_score = User.Score - Critic.Score) %>%
  arrange(desc(difference_in_score)) %>%
  select(Game, difference_in_score, Total.Sales, User.Score, Critic.Score)

df_example_8 <- df %>%
  group_by(Console) %>%
  summarise(Total.Sales.all.games = sum(Total.Sales, na.rm = TRUE),
            NA.Sales.all.games = sum(NA.Sales, na.rm = TRUE),
            Japan.Sales.all.games = sum(Japan.Sales, na.rm = TRUE),
            PAL.Sales.all.games = sum(PAL.Sales, na.rm = TRUE)) %>%
  mutate(jp.percentage = Japan.Sales.all.games/Total.Sales.all.games) %>%
  arrange(desc(jp.percentage)) %>%
  filter(jp.percentage < 1)
df_example_8


## Visualizations
# Visualization 1
df_example_7 <- df %>%
  filter(is.na(Critic.Score) == FALSE,
         is.na(User.Score) == FALSE) %>%
  mutate(difference_in_score = User.Score - Critic.Score) %>%
  arrange(desc(difference_in_score)) %>%
  select(Game, difference_in_score, Total.Sales, User.Score, Critic.Score)

p <- ggplot(data = df_example_7, mapping = aes(x = Critic.Score, y = User.Score, size = Total.Sales)) 
p <- p + geom_point() 
p <- p + theme_bw()
p <- p + labs(x = 'Critic Score', y = 'User Score', title = 'How does the critic score compare to user score for top sold games?', size = 'Total Sales')
p

# Visualization 2
df_example_9 <-
  df %>% 
  filter(Console %in% c('PS', 'PS2', 'PS3', 'PS4'), Release.Year >= 1994) %>% 
  group_by(Release.Year) %>% 
  summarise(Total.Sales = sum(Total.Sales, na.rm = T)) 

df_example_9

p <- ggplot(data = df_example_9, mapping = aes(x = Release.Year, y = Total.Sales)) 
p <- p + geom_line()
p <- p + geom_point()
p <- p + theme_bw()
p <- p + labs(x = 'Release Year', y = 'Total Sales', title = 'Total PlayStation Games Sales over Years')
p 

# Visualization 3 
df_example_10 <-
  df %>% 
  filter(Console %in% c('PS', 'PS2', 'PS3', 'PS4'), Release.Year >= 1994) %>% 
  group_by(Release.Year, Console) %>% 
  summarise(Total.Sales = sum(Total.Sales, na.rm = T)) 

df_example_10

p <- ggplot(data = df_example_10, mapping = aes(x = Release.Year, y = Total.Sales, color = Console)) 
p <- p + geom_line()
p <- p + geom_point()
p <- p + theme_bw()
p <- p + labs(x = 'Release Year', y = 'Total Sales', title = 'How many PlayStation games (by models) are sold over the years?', color = 'Console Type')
p 

# Visualization 4
df_example_11 <- 
  df_example_8 %>% 
  gather(key = region, value = sales, NA.Sales.all.games, Japan.Sales.all.games, PAL.Sales.all.games)  

p <- ggplot(data = df_example_11, mapping = aes(x = reorder(Console, sales), y = sales, fill = region)) 
p <- p + geom_col()
p <- p + theme_bw() 
p <- p + coord_flip()
p <- p + labs(x = 'Console', y = 'Total Sales', title = 'How many games are sold (by console type) in different regions?', fill = 'Region')
p

