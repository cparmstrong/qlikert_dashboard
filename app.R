

library(shiny)

library(dplyr)
library(forcats)
library(ggplot2)
library(stringr)
library(tidyr)

source(paste0(getwd(), "/example_data.R"))
source(paste0(getwd(), "/functions/qlikert_clean.R"))
source(paste0(getwd(), "/functions/qlikert_order.R"))
source(paste0(getwd(), "/functions/qlikert_plot.R"))

qlikert_clean(example_data)
qlikert_order(unique(dat_scale$q))

question_choices <- unique(dat_scale$q)

ui <- fluidPage(
  titlePanel("Plot Likert Graphs from Qualtrics for CRRE"),
  sidebarLayout(
    sidebarPanel(
      textInput(
        inputId     = "natext",
        label       = "Unknown/Unsure Response Text",
        placeholder = "Not Applicable"
      ),
      selectInput(  # selectize(multiple,)
        inputId     = "question_toplot",
        label       = "Question",
        choices     = NULL,
        selected    = NULL
      ),
      textInput(  # need to give perfect format
        inputId     = "savepath",
        label       = "Folder to save the graphs:",
        placeholder = "C:/Users/JohnDoe/Desktop/Project/"
      ),
      actionButton(  
        inputId     = "savebutton",
        label       = "Save Graphs",
        placeholder = "C:/Users/JohnDoe/Desktop/Project/"
      )
    ),
    mainPanel(
      plotOutput("theplot"),
      tags$h4("https://github.com/cparmstrong/qlikert_dashboard"),
      tags$ul(
        tags$li("Figure out why unsure filter isn't working"),
        tags$li("Add checkboxInput to include missing responses (need to conditionally pipe the filter in qlikert_clean())"),
        tags$li("Add greys to cols for unknown + missing"),
        tags$li("Move unknown/missingi to left end (right justify by sort fields agree+strongagree"),
        tags$li("Generate temporary static legend (later, make code work for app+output)"),
        tags$li("Convert queestion field to selectizeInput with multiple selection allowed and loop through questions"),
        tags$li("Split files to server+ui (where do util functions go?)")
      )
    )
    )
)
# 

server <- function(input, output, session) {
  updateSelectInput(
    session = session,
    inputId = "question_toplot",
    choices = question_choices)

  qlikert_clean(example_data)
  qlikert_order(unique(dat_scale$q)) 
  output$theplot <- renderPlot({
    qlikert_plot(input$question_toplot)
  })
  
  observeEvent(input$savebutton, {
    savepath <- gsub("\\\\", "/", input$savepath)
    qlikert_plot(input$question_toplot,
                 SAVE = TRUE,
                 DIR  = savepath)
  })

}


# Run the application 
shinyApp(ui = ui, server = server)

# deploy to shinyapps.io
# rsconnect::deployApp("C:/Users/carmst18/Desktop/CPA_JHU_CRRE/rmstrong/qlikert_dashboard")
