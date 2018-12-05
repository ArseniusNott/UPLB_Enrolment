#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(plotly)
library(shiny)
library(dplyr)
library(ggplot2)

uplb_enrolment <- read.csv("1st_semester_2018-2019_GS_enrollment_By_College_Program.csv")

# Define server logic required to draw a histogram
shinyServer(function(input, output, session) {
  m <- list(
    l = 50,
    r = 10,
    b = 200,
    t = 50,
    pad = 10
  )
  
  general.font <- list(
    family='Old Standard TT, serif',
    size=8,
    color='black'
  )
  
  x <- list(
    tickangle=-90,
    tickfont = general.font,
    tickformat = '.0f',
    automargin = TRUE,
    title = 'Program Name'
  )
  
  y <- list(
    tickfont = general.font,
    tickformat = '.0f',
    automargin = TRUE,
    title = 'Count'
  )
  
  observeEvent(input$college, {
    updateSelectInput(session = session, 
                      inputId = 'degree', 
                      choices = unique(as.character(uplb_enrolment[uplb_enrolment$college == input$college, "degree"])))
  })
  
  output$plot <- renderPlotly({
    college <- input$college
    degree <- input$degree
    
    data <- uplb_enrolment[(uplb_enrolment$college == college) & 
                              (uplb_enrolment$degree == degree) &
                              (uplb_enrolment$count != 0), 
                           c("program", "count")]
    data <- data %>%
      mutate(program = gsub("_", " ", as.character(program)))
    
    pl <- plot_ly(data = data, x = ~program, y = ~count, type = "bar") %>%
      layout(xaxis = x, yaxis = y, margin = m, 
             title = paste(gsub("_", " ", college), "\n", 
                           gsub("_", " ", degree)))
    pl$elementId <- NULL
    pl
  })
})

