library(data.table)

Dataset <- fread('./data/worked_data.csv',stringsAsFactors = T)
Dataset[,Release.Date.Pretty :=as.Date(fasttime::fastPOSIXct(x = Release.Date.Pretty))]
Dataset[,Last.Update.Pretty :=as.Date(fasttime::fastPOSIXct(x = Last.Update.Pretty))]
Dataset[,Total.Sales := ifelse(is.na(Total.Sales) , 0 , Total.Sales)]

Dataset %<>% mutate(
  Release.Month = lubridate::month(Release.Date.Pretty , label = T),
  Release.Year = year(Release.Date.Pretty)
)
