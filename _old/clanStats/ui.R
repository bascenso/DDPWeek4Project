#

library(shiny)

clanStatsDF <- readRDS("stats.RDS")

plotColors <- list("red", "green", "blue", "black", "grey", "orange", "pink")
plotStats <- names(clanStatsDF)[2:11]


shinyUI(fluidPage(
    
    # Application title
    titlePanel("Alkateia PT Clan Stats Plot | Clash Royale"),

    # Sidebar with inputs
    sidebarLayout(
        sidebarPanel(
            selectInput("theStat", "Select a stat to plot:", plotStats),
            selectInput("theColor", "Select a color:", plotColors),
            checkboxInput("includeMean", "Add line at the mean?", value = FALSE)
        ),
        
        # Show a plot of the selected statistic
        mainPanel(
            h3(textOutput("outDesc")),
            plotOutput("statsPlot")
        )
    )
))
