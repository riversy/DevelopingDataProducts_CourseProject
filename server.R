library(shiny)
library(ggplot2)

shinyServer(
  function(input, output) {

    # Define a reactive
    # expression for the
    # document term matrix
    bookTerms <- reactive({
      getTermMatrixPerBook(input$book, input$qty)
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
        min.freq = 1,
        max.words=input$qty,
        colors=brewer.pal(
          8,
          "Dark2"
        )
      )
    })

    perChapterDataFrame <- reactive({
      getPerChapterDataFrame(input$book, input$qty)
    })

    output$usage <- renderPlot({
      df <- perChapterDataFrame()

      ggplot(
        df,
        aes(
          x=chapter,
          y=count,
          fill=word)
        ) +
        geom_bar(stat="identity")  +
        facet_wrap( ~ word, ncol = 2) +
        theme(axis.text.x=element_blank())
    })
  }
)
