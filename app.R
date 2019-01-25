

library(shiny)

ui <- fluidPage(
   
   titlePanel("Plot Likert Graphs from Qualtrics for CRRE"),
 
   sidebarLayout(
     
      sidebarPanel(
        
        # actionButton(
        #   inputId     = "loaddata", 
        #   label       = "Load Plots"),
        
        textInput(
          inputId     = "natext",
          label       = "Unknown/Unsure Response Text",
          placeholder = "Not Applicable"
        ),
        
        # temporary
        textInput(
          inputId     = "question_toplot",
          label       = "Question",
          placeholder = "Q1"
        ),

        # uiOutput("question_numbers"),
        
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

  # qlikert_clean(example_dat, input$NATEXT)
  
  # observeEvent(input$loaddata, {
  #   output$dat_scale <- qlikert_clean(example_data, input$natext)
  #   output$dat_scale_agree <- qlikert_order(unique(dat_scale$q), DATA = output$dat_scale)
  # })

    
  # output$question_numbers <- renderUI({
  #   selectInput(
  #     inputId       = "question_toplot",
  #     label         = "Question Number",
  #     choice        = unique(output$dat_scale$q))
  # })
  
  observeEvent(input$showplots, {
    qlikert_clean(example_data, input$natext)
    qlikert_order(unique(dat_scale$q))
    output$theplot <- renderPlot({
      qlikert_plot(input$question_toplot)
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
# need to somehow show %NA

# Run the application 
shinyApp(ui = ui, server = server)





# deploy to shinyapps.io
# rsconnect::deployApp("C:/Users/carmst18/Desktop/CPA_JHU_CRRE/rmstrong/qlikert_dashboard")
