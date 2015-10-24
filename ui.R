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
              "qty",
              "Quantity of top words:",
              min = 1,
              max = 100,
              value = 30
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
