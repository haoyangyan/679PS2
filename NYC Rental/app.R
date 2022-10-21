library(tidyverse)
library(shiny)
NYC <- read_csv('airbnb.csv')

reset_selection <- function(x, brush) {
  brushedPoints(x, brush, allRows = TRUE)$selected_
}

scatter <- function(x, selected_, var1, var2) {
  x %>%
    mutate(selected_ = selected_) %>%
    ggplot(aes_string(var1, var2)) +
    geom_point(aes(alpha = as.numeric(selected_), col = room_type)) +
    scale_alpha(range = c(0.1, 1))
}

histogram <- function(NYC, selected_) {
  nei_price <- NYC %>%
    filter(selected_) %>%
    group_by(neighbourhood)%>%
    summarise(mean(price))
    
  NYC %>%
    group_by(neighbourhood)%>%
    summarise(mean(price))%>%
    ggplot(aes(neighbourhood, `mean(price)`)) +
    geom_bar(stat = "identity", fill = "#d3d3d3", width = 1) +
    geom_bar(data = nei_price, stat = "identity", width = 1) +
    scale_y_continuous(expand = c(0, 0))
}


ui <- fluidPage(
  fluidRow(
    column(6, plotOutput("scatter1", brush = "plot_brush")),
    column(6, plotOutput("hist", brush = brushOpts("plot_brush", direction = "x")))
  )
)

server <- function(input, output) {
  selected <- reactiveVal(rep(TRUE, nrow(NYC)))
  
  observeEvent(
    input$plot_brush,
    selected(reset_selection(NYC, input$plot_brush))
  )
  
  output$scatter1 <- renderPlot({
    scatter(NYC, selected(), "latitude", "longitude")
  })
  output$hist <- renderPlot(histogram(NYC, selected()))
}

shinyApp(ui, server)