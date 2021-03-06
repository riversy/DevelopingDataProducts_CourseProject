# Course Project on Developing Data Products
There's my Course Project on Developing Data Products course on [Coursera][1].

It consist of two parts. First part is **Shiny** app. And the second one is the **Slidify** presentation.

## How to use Shiny app

If you want to start this app, please install necessary packages in your **RStudio** or **R Console**.

```{r}
install.packages(
  c(
    "shiny",
    "ggplot2",
    "tm",
    "wordcloud",
    "memoise"
  )
)
```

After that please clone the repository and set it's directory as *working directory* using following command.

```{r}
setwd("<directory with the repo>")
```

After that you may use command ``runApp()`` to start this Shiny application.

## Presentation

The presentation for this project is placed [here][3].

## Demo

The project was also deployed on [shinyapps][4] server.

## Support

There's no support here but please feel free to issue questions [here][2].

  [1]: https://class.coursera.org/devdataprod-033 "Developing Data Products"
  [2]: https://github.com/riversy/DevelopingDataProducts_CourseProject/issues/new "Submit new issue"
  [3]: http://riversy.github.io/DevelopingDataProducts_CourseProject/presentation/index.html "Presentation"
  [4]: https://riversy.shinyapps.io/DevelopingDataProducts_CourseProject "Text Analysis App"
