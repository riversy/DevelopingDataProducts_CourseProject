library(shiny)

shinyUI(
  fluidPage(
    navbarPage("Text Analysis",
      tabPanel(
        "App",
        sidebarLayout(
          sidebarPanel(
            selectInput(
              "book",
              "Choose a book for analysis:",
              choices = books
            ),
            hr(),
            sliderInput(
              "freq",
              "Minimum Frequency:",
              min = 1,
              max = 50,
              value = 15
            ),
            sliderInput(
              "max",
              "Maximum Number of Words:",
              min = 1,
              max = 300,
              value = 100
            )
          ),
          mainPanel(
            plotOutput("wordcloud")
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
