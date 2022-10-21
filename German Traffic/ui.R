library(tidyverse)
library(shiny)
library(lubridate)
traffic <- read_csv("https://uwmadison.box.com/shared/static/x0mp3rhhic78vufsxtgrwencchmghbdf.csv") %>%
  mutate(day_of_week = wday(date))

fluidPage(
  titlePanel("Interactive German Traﬃc"),
  selectInput("cities", "cities", unique(traffic$name), multiple = TRUE),
  sliderInput("weekday", "weekday",min = 1, max = 7, value = c(1,7)),
  plotOutput("scatterplot")
)