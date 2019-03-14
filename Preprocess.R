library(data.table)

df <- fread('./data/worked_data.csv',stringsAsFactors = T)

df %<>% mutate(
  Release.Month = lubridate::month(Release.Date.Pretty , label = T),
  Release.Year = year(Release.Date.Pretty)
)
