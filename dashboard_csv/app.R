

library(shiny)

ui <- fluidPage(
   
   titlePanel("Plot Likert Graphs from Qualtrics for CRRE"),
   
   # Sidebar with a slider input for number of bins 
   sidebarLayout(
      sidebarPanel(
         sliderInput("bins",
                     "Number of bins:",
                     min = 1,
                     max = 50,
                     value = 30)
      ),
      
      # Show a plot of the generated distribution
      mainPanel(
         plotOutput("distPlot")
      )
   )
)

server <- function(input, output) {
   
 
}

# Run the application 
shinyApp(ui = ui, server = server)

