

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

      selectInput(
        inputId     = "question_toplot",
        label       = "Question",
        choices     = NULL,
        selected    = NULL
      ),
      actionButton(
        inputId     = "showplots",
        label       = "Show Plots")
      
      
    ),
    
    mainPanel(
      plotOutput("theplot"),
      print("https://github.com/cparmstrong/qlikert_dashboard")
    )
  )
)



# 

server <- function(input, output, session) {
  updateSelectInput(
    session = session,
    inputId = "question_toplot",
    choices = question_choices)
  
  # observeEvent(input$showplots, {
    qlikert_clean(example_data)
    qlikert_order(unique(dat_scale$q)) 
    output$theplot <- renderPlot({
      qlikert_plot(input$question_toplot)
  # })
      })

}

# why isn't the grey on "unsure" category working?
# # that will need to be moved to the other end when it is
# where is my legend? 
# # probably bc of the movement of it
# any time the sidebar is changed it should auto-clear
# need to somehow show %NA

# Run the application 
shinyApp(ui = ui, server = server)

# deploy to shinyapps.io
# rsconnect::deployApp("C:/Users/carmst18/Desktop/CPA_JHU_CRRE/rmstrong/qlikert_dashboard")
