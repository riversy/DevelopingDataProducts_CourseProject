library(shiny)

shinyServer(
  function(input, output) {

    # Define a reactive
    # expression for the
    # document term matrix
    bookTerms <- reactive({
      getTermMatrixPerBook(input$book)
    })

    # Make the wordcloud
    # drawing predictable
    # during a session
    wordcloud_rep <- repeatable(wordcloud)

    output$wordcloud <- renderPlot({
      v <- bookTerms()
      wordcloud_rep(
        names(v),
        v,
        scale=c(4, 0.5),
        min.freq = input$freq,
        max.words=input$max,
        colors=brewer.pal(
          8,
          "Dark2"
        )
      )
    })
  }
)
