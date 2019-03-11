
# Themes ------------------------------------------------------------------


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


# Axesformats -------------------------------------------------------------

MoneyAxisFormat <- scales::dollar_format(suffix = "€", prefix = "")
