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
              max = 15,
              value = 10
            )
          ),
          mainPanel(
            tabsetPanel(
              tabPanel(
                "Words Cloud",
                plotOutput(
                  "wordcloud"
                )
              ),
              tabPanel(
                "Per Chart Usage",
                plotOutput(
                  "usage"
                )
              )
            )
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
