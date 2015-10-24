library(shiny)
library(ggplot2)

shinyServer(
  function(input, output) {
    ###
    # Prepare "Words Cloud" plot
    ###

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

    ###
    # Prepare "Per Chapter Usage" plot
    ###

    perChapterDataFrame <- reactive({
      getPerChapterDataFrame(input$book, input$qty)
    })

    getColCount <- reactive({
      min( c(ceiling(input$qty / 10), 3) )
    })

    height <- reactive({
      colCount <- getColCount()
      round(input$qty / colCount * 100)
    })

    output$usage <- renderPlot({

      colCount <- getColCount()

      df <- perChapterDataFrame()

      ggplot(
        df,
        aes(
          x=chapter,
          y=count,
          fill=word)
        ) +
        geom_bar(stat="identity")  +
        facet_wrap( ~ word, ncol = colCount) +
        theme(
          axis.text.x=element_blank(),
          legend.position="none"
        )
    }, height = height)
  }
)
