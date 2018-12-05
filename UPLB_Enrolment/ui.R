library(plotly)
library(shiny)

uplb_enrolment <- read.csv("1st_semester_2018-2019_GS_enrollment_By_College_Program.csv")
colleges <- as.character(unique(uplb_enrolment$college))
degrees <- unique(as.character(uplb_enrolment[uplb_enrolment$college == "College_of_Agriculture_and_Food_Science", 
                                              "degree"]))

shinyUI(fluidPage(
  fluidPage(
    column(width = 10, offset = 1, titlePanel("University of the Philippines - Los Baños 1st Semester Enrolment for School Year 2018-2019")),
    tags$br()
  ),
  sidebarLayout(
    sidebarPanel(
      selectInput(inputId = "college", label = "College: ", choices = colleges),
      selectInput(inputId = "degree", label = "Degree: ", choices = degrees, selected = degrees[1])
    ),
    mainPanel(
      plotlyOutput(outputId = "plot")
    )
  )
))
