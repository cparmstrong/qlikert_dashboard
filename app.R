

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
      "Explore Visualizations",
      selectInput(  # selectize(multiple,)
        inputId     = "question_toplot",
        label       = "Question",
        choices     = NULL,
        selected    = NULL
      ),
      textInput(
        inputId     = "natext",
        label       = "Unknown/Unsure Response Text",
        placeholder = "Not Applicable"
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
    sidebarPanel(
      "Export Graphs",
      textInput(  # need to give perfect format
        inputId     = "data_file",
        label       = "Filepath of Qualtrics CSV export:",
        placeholder = "C:/Users/JohnDoe/Desktop/Project/"
      ),
    )
    mainPanel(
      plotOutput("theplot"),
      tags$h4("https://github.com/cparmstrong/qlikert_dashboard"),
      tags$ul(
        tags$li("Unsure filter currently is only functional for saving graphs; add to preview mode"),
        tags$li("Add checkboxInput to include missing responses (need to conditionally pipe the filter in qlikert_clean())"),
        tags$li("Add lgrey/dgrey to cols for unsure/missing"),
        tags$li("Move unknown/missing to left end (right justify by sort fields agree+strongagree"),
        tags$li("Generate static legend (later add it so it shows in preview mode"),
        tags$li("Convert question field to selectizeInput with multiple selection allowed and loop through questions"),
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
    savepath <- ifelse(str_sub(savepath, -1, -1)!="/",
                       paste0(savepath, "/"),
                       savepath)
    qlikert_clean(example_data, input$natext)
    qlikert_order(unique(dat_scale$q)) 
    qlikert_plot(input$question_toplot,
                 SAVE = TRUE,
                 DIR  = savepath)
  })

}


# Run the application 
shinyApp(ui = ui, server = server)

# deploy to shinyapps.io
# rsconnect::deployApp("C:/Users/carmst18/Desktop/CPA_JHU_CRRE/R/rmstrong/qlikert_dashboard")
