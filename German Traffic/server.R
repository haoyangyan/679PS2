library(tidyverse)
library(shiny)
library(lubridate)
traffic <- read_csv("https://uwmadison.box.com/shared/static/x0mp3rhhic78vufsxtgrwencchmghbdf.csv") %>%
  mutate(day_of_week = wday(date))

function(input, output) {
  output$scatterplot <- renderPlot({
    sdata <- traffic %>%
      filter(name %in% input$cities) %>%
      filter(day_of_week >= input$weekday[1] & day_of_week <= input$weekday[2])
    ggplot() +
      geom_point(data=traffic, aes(date,value),size=1) +
      geom_point(data=sdata, aes(date,value), size=2,  colour='red')
  })
}