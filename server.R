#
# Define how the distribution is selected and calculated
#
#

library(shiny)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
   
  
        # Generate the distribution user chose
        # This will get modified according to the selection 
        
        diagram <- reactive({
                dist <- switch (input$dist,
                                unif = runif,
                                norm = rnorm,
                                exp= rexp,
                                cauchy = rcauchy,
                                unif)
              
                dist(input$n)
               
               
        })
        
        # Generate the distribution graphing from selection
        # Toggle between tabs to select either graph or summary
        
        output$plot <- renderPlot({
                
                dist <- input$dist
                n <- input$n
                
                hist(diagram(),
                     main= paste("r", dist,"(",n,")",sep = ""),
                     col = "#5e9da5", border="black")
        })
        
        # Generate the data summary
        output$summary <- renderPrint({
                summary(diagram())
        })
        
        
})
