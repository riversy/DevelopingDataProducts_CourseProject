library(shiny)

shinyUI(
  
  fluidPage(
    navbarPage("Text Analysis",
      tabPanel("App"),
      tabPanel("Guide"),
      mainPanel(
       tabPanel("App", HTML("I'm app.")),
       tabPanel("Guide", HTML("I'm guide."))
      )
    ) 
  )
)