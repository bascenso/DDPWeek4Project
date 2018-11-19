#

library(shiny)

clanStatsDF <- readRDS("stats.RDS")

shinyServer(function(input, output) {
    
    output$outDesc <- renderText(paste("Plot of", input$theStat, "in", input$theColor))

    output$statsPlot <- renderPlot({

        plot(clanStatsDF$timestamp, clanStatsDF[, input$theStat], type = "l", lwd = 2, 
             col = input$theColor, xlab = "Time", ylab = input$theStat)
        
        if (input$includeMean)
            abline(h = mean(clanStatsDF[, input$theStat]), col = "tomato", lwd = 3)
        
    })
    
})

