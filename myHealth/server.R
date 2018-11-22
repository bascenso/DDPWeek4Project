#

library(shiny)
library(ggplot2)

health <- readRDS("health.RDS")

shinyServer(function(input, output) {
    
    # Histogram plot

    output$histTitle <- renderText({
        paste("Histogram of heart rate from", 
              paste(as.character(input$dateRange), collapse = " to ")
        )
    })
    
    output$minRate <- renderText({
        rate <- min(health[(health$hrate != 0) & (as.Date(health$finish) > input$dateRange[1]) & (as.Date(health$finish) < input$dateRange[2]), ]$hrate)
        paste("Min. heart rate: ", rate, "/min", sep = "")
    })
    
    output$maxRate <- renderText({
        rate <- max(health[(health$hrate != 0) & (as.Date(health$finish) > input$dateRange[1]) & (as.Date(health$finish) < input$dateRange[2]), ]$hrate)
        paste("Max. heart rate: ", rate, "/min", sep = "")
    })
    
    output$meanRate <- renderText({
        rate <- mean(health[(health$hrate != 0) & (as.Date(health$finish) > input$dateRange[1]) & (as.Date(health$finish) < input$dateRange[2]), ]$hrate)
        paste("Mean heart rate: ", round(rate, 0), "/min", sep = "")
    })
    
    output$histPlot <- renderPlot({
        
        p <- ggplot(health[(health$hrate != 0) & (as.Date(health$finish) > input$dateRange[1]) & (as.Date(health$finish) < input$dateRange[2]), ])
        p <- p + aes(hrate)
        p <- p + geom_histogram(binwidth = 5, color = "red", fill = "orange")
        p <- p + theme_classic() + theme(legend.position = "none")
        p <- p + labs(x = "Heart rate (count/min)", y = "Number of occurrences")
        print(p)
        
    })
    
    
    # Steps plot
    output$stepsTitle <- renderText({
        paste("Plot of steps from", paste(as.character(input$dateRange2), collapse = " to "), "by", input$stepsBy)
    })
    

    output$stepsPlot <- renderPlot({
        
        # Get only relevant dates
        stepsData <- health[(as.Date(health$finish) > input$dateRange2[1]) & (as.Date(health$finish) < input$dateRange2[2]), c("finish", "steps")]
        
        
        # Group by selected period
        if (input$stepsBy == "Day") {
            stepsData$period <- strftime(stepsData$finish, format = "%Y-%m-%d")
            
        } else if (input$stepsBy == "Week") {
            stepsData$period <- strftime(stepsData$finish, format = "%Y-W%V")

        } else { # Month
            stepsData$period <- strftime(stepsData$finish, format = "%Y-%b")
        }

        # Show the plot
        p <- ggplot(stepsData)
        p <- p + aes(period, steps, fill = steps)
        p <- p + geom_bar(stat = "identity", fill = "skyblue")
        p <- p + theme_classic() + theme(legend.position = "none")
        p <- p + labs(x = input$stepsBy, y = "Total steps")
        print(p)
    })
    
})
