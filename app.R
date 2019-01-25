

library(shiny)

ui <- fluidPage(
   
   titlePanel("Plot Likert Graphs from Qualtrics for CRRE"),
 
   sidebarLayout(
     
      sidebarPanel(
        
        textInput(
          inputId     = "natext",
          label       = "Unknown/Unsure Response Text",
          placeholder = "Not Applicable"
        ),
        
        # temporary
        textInput(
          inputId     = "question_number",
          label       = "Question",
          placeholder = "Q1"
        ),
        
        # selectInput(
        #   inputId     = "COLS",
        #   label       = "Color Scale",
        #   choices     = c("Clay Default" = clay_cols),
        #   selected    = "Clay Default"
        # ),
        
        actionButton(
          inputId     = "showplots", 
          label       = "Show Plots"),
        actionButton(
          inputId     = "saveplots", 
          label       = "Export Plots"),
        actionButton(
          inputId     = "clearplots", 
          label       = "Clear Plots"),
        
        print("https://github.com/cparmstrong/qlikert_dashboard")
      ),
      
      mainPanel(
        plotOutput("theplot")
      )
   )
)
   


# 

server <- function(input, output) {
  library(dplyr)
  library(forcats)
  library(ggplot2)
  library(stringr)
  library(tidyr)
  
  source(paste0(getwd(), "/example_data.R"))
  source(paste0(getwd(), "/functions/qlikert_clean.R"))
  source(paste0(getwd(), "/functions/qlikert_order.R"))
  source(paste0(getwd(), "/functions/qlikert_plot.R"))
  # source("/example_data.R")
  # source("/functions/qlikert_clean.R")
  # source("/functions/qlikert_order.R")
  # source("/functions/qlikert_plot.R")
  # qlikert_clean(example_dat, input$NATEXT)
  
  
  observeEvent(input$showplots, {
    qlikert_clean(example_data, input$natext)
    qlikert_order(unique(dat_scale$q))  # does them all
    output$theplot <- renderPlot({
      qlikert_plot(input$question_number)
      })
    })
  
  observeEvent(input$clearplots, {
    output$theplot <- NULL
    })
}

# why isn't the grey on "unsure" category working?
# # that will need to be moved to the other end when it is
# where is my legend? 
# # probably bc of the movement of it
# any time the sidebar is changed it should auto-clear


# Run the application 
shinyApp(ui = ui, server = server)





# deploy to shinyapps.io
# rsconnect::deployApp("C:/Users/carmst18/Desktop/CPA_JHU_CRRE/rmstrong/qlikert_dashboard")