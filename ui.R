library(shiny)

shinyUI(
  
  fluidPage(
    navbarPage("Text Analysis",

      tabPanel(
        "App", 
        sidebarLayout(
          sidebarPanel(
            radioButtons("plotType", "Plot type",
                         c("Scatter"="p", "Line"="l")
            )
          ),
          mainPanel(
            plotOutput("plot")
          )
        )         
      ),
      tabPanel(
        "Guide", 
        fluidRow(
          column(12, 
            includeMarkdown("guide.md")
          )
        )
      )
    )
  ) 
)
