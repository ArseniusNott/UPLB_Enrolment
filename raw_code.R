# create the plot for the second project

# Developing Data Products course on Coursera Data Science Specialization

library(plotly)
library(shiny)
library(dplyr)

setwd("./Projects/Courses/Coursera/Developing Data Products/Project_2/")
uplb_enrolment <- read.csv("1st_semester_2018-2019_GS_enrollment_By_College_Program.csv")

colleges <- as.character(unique(uplb_enrolment$college))

enrolment_gadget <- function() {
  ui <- miniPage(
    gadgetTitleBar("UPLB Enrolment"),
    miniContentPanel(
      selectInput(inputId = "college", label = "College: ", choices = colleges),
      selectInput(inputId = "program", label = "Program", choices = "Select College from the dropdown list"),
      plotOutput(outputId = "plot", height = "100%")
    )
  )
  server <- function(input, output, session) {
    output$plot <- renderPlot({
      data <- uplb_enrolment[uplb_enrolment$college == input$college, c("degree", "program", "count")]
      plot_ly(data = data, x = ~program, y = ~count, type = "bar")
    })
    observeEvent(input$done, {
      # TODO Implement this later
    })
    observeEvent(input$cancel, {
      stopApp()
    })
  }
  runGadget(ui, server)
}



library(shiny)
library(plotly)
library(shinyjs)

ui <- shinyUI(
  fluidPage(
    useShinyjs(),
    # code to reset plotlys event_data() to NULL -> executed upon action button click
    # note that "A" needs to be replaced with plotly source string if used
    extendShinyjs(text = "shinyjs.resetClick = function() { Shiny.onInputChange('.clientValue-plotly_click-A', 'null'); }"),
    actionButton("reset", "Reset plotly click value"),
    plotlyOutput("plot"),
    verbatimTextOutput("clickevent")
  )
)


server <- shinyServer(function(input, output) {
  
  output$plot <- renderPlotly({
    plot_ly(mtcars, x=~cyl, y=~mpg)
  })
  
  output$clickevent <- renderPrint({
    event_data("plotly_click")
  })
  
  observeEvent(input$reset, {
    js$resetClick()
  })
})

shinyApp(ui, server)
