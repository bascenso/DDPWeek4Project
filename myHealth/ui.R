#

library(shiny)
library(shinyWidgets)

byChoices <- c("Month", "Week", "Day")


shinyUI(fluidPage(
    
    # Application title
    titlePanel("Analyzing health data"),
    p("This app shows some of my health data, collected by the Apple Watch."),
    p("The data has been collected from December 2016 up to today and downloaded using the app QS Access by", 
      a(href = "http://quantifiedself.com/", "Quantified Self Labs")),
    p("The metrics used in this app are Heart Rate (count/min, average in 1hr periods) and Number of Steps."),
    p(strong("Usage:")),
    p("1. Enter a date range to select the period for the heart rate histogram"),
    p("2. Select a data range and a grouping period to display the steps plot (per day, per week or per month)"),
    br(),
    p(strong("Note on using the date picker control:")), 
    p("Click inside the control, select the Clear button below the calendar, pick the two dates and close the calendar."),
    p("The plots only refresh after you close the app."),
    hr(),

    # Histogram of heart rate
    h2("Histogram of heart rate"),
    sidebarLayout(
        sidebarPanel(
            airDatepickerInput(
                inputId = "dateRange",
                label = "Select start and end dates (press Clear to start again):",
                placeholder = "Click and pick two dates",
                separator = " to ",
                minDate = as.Date("2016-12-19"),
                maxDate = as.Date("2018-11-22"),
                value = c(as.Date("2016-12-19"), as.Date("2018-11-22")),
                multiple = 2, clearButton = TRUE,
                update_on = "close"
            )
        ),
        
        mainPanel(
            h3(textOutput("histTitle")),
            plotOutput("histPlot"),
            p(""),
            p(strong("Summary of data:")),
            h4(textOutput("minRate")),
            h4(textOutput("maxRate")),
            h4(textOutput("meanRate"))
        )
    ),
    hr(),
    
    # Plot of steps
    h2("Plot of steps"),
    sidebarLayout(
        sidebarPanel(
            airDatepickerInput(
                inputId = "dateRange2",
                label = "Select start and end dates (press Clear to start again):",
                placeholder = "Click and pick two dates",
                separator = " to ",
                minDate = as.Date("2016-12-19"),
                maxDate = as.Date("2018-11-22"),
                value = c(as.Date("2017-12-01"), as.Date("2018-10-31")),
                multiple = 2, clearButton = TRUE
            ),
            br(),
            prettyRadioButtons(inputId = "stepsBy", label = "Select grouping period", thick = TRUE, choices = byChoices, 
                               inline = TRUE, shape = "round", animation = "rotate", plain = FALSE, bigger = TRUE)
        ),
        
        # Show a plot of the selected statistic
        mainPanel(
            h3(textOutput("stepsTitle")),
            plotOutput("stepsPlot")
        )
    ),
    hr(),
    p("Author: Bruno Ascenso"),
    p("Date: November 22, 2018"),
    p("Source code available in ", a(href = "https://github.com/bascenso/DDPWeek4Project", "GitHub"))
))
