###
# Reusable Parts
###

library(tm)
library(wordcloud)
library(memoise)
library(markdown)

# The list of valid books
books <<- list(
  "Sense and Sensibility" = "austen",
  "Moby Dick; or The Whale" = "melville"
)

###
# Validate if the book
# is in our list
###
validateBook <- function (book){
  if (!(book %in% books)){
      stop("I don't know this book")
  }
}

###
# Extract book lines
###
getBookLines <- memoise(function(book){
  # Validate book
  validateBook(book)

  # Build filename
  fileName <- paste(c("data/", book, ".txt"), collapse = "")

  # Read book from file
  text.v <- scan(fileName, what="character", sep="\n")

  # Define first and last lines
  chapter.1.position <- grep("^CHAPTER 1", text.v)
  the.end.position <- grep("^THE END", text.v)

  # Cut subsequence
  # with book's lines
  # only
  text.v[chapter.1.position:the.end.position]
})

###
# Get whole text of a book
###
getBookText <- memoise(function(book){
  book.lines <- getBookLines(book)
  paste(book.lines, collapse = " ")
})

###
# Get the list of chapters
###
getBookChapters <- function(book){

  # Create empty
  # vector for
  # chapters
  chapters <- c()

  book.lines <- getBookLines(book)
  book.lines.qty <- length(book.lines)

  chapter.positions <- grep("^CHAPTER \\d", book.lines)
  chapter.qty <- length(chapter.positions)

  for (i in 1:(chapter.qty - 1)){

      chapter.lines <- book.lines[chapter.positions[i]:chapter.positions[i + 1]]
      chapter <- paste(chapter.lines, collapse = " ")
      chapters <- c(chapters, chapter)
  }

  # Add last chapter
  chapter.lines <- book.lines[chapter.positions[chapter.qty]:book.lines.qty]
  chapter <- paste(chapter.lines, collapse = " ")
  chapters <- c(chapters, chapter)

  # Return
  # chapters
  chapters
}

getTermMatrixPerBook <- memoise(function(book, qty){
  text <- getBookText(book)
  matrix <- getTermMatrix(text)
  matrix[1:qty]
})

getPerChapterDataFrame <- memoise(function(book, qty){

  # Find words we should use
  text <- getBookText(book)
  matrix <- getTermMatrix(text)
  matrix <- matrix[1:qty]
  words <- names(matrix)

  # Get chapters
  chapters <- getBookChapters(book)

  # Collect data
  chapterV <- c()
  wordV <- c()
  countV <- c()

  for (j in 1:length(words)) {

    word <- words[j]

    for (i in 1:length(chapters)){

      chapter <- chapters[i]
      chapterMatrix <- getTermMatrix(chapter)

      chapterV <- c(chapterV, i)
      wordV <- c(wordV, word)

      if (word %in% names(chapterMatrix)){

        countV <- c(countV, chapterMatrix[[word]])

      } else {

        countV <- c(countV, 0)
      }
    }
  }


  # Build data frame
  # with data
  df <- data.frame(chapter = chapterV, word = wordV, count = countV)
  df$chapter <- as.factor(df$chapter)
  df$word <- factor(df$word, levels = words)
  df$count <- as.numeric(df$count)

  df
})

###
# Get term Matrix for piece of text
###
getTermMatrix <- memoise(function(text) {

  # Prepare corpus of words
  corpus = Corpus(VectorSource(text))
  corpus = tm_map(corpus, content_transformer(tolower))
  corpus = tm_map(corpus, removePunctuation)
  corpus = tm_map(corpus, removeNumbers)
  corpus = tm_map(corpus, removeWords, stopwords("english"))

  # Build terms matrix
  myDTM =
    TermDocumentMatrix(
      corpus,
      control = list(minWordLength = 1)
    )
  matrix = as.matrix(myDTM)

  # Sort the matrix
  sort(rowSums(matrix), decreasing = TRUE)
})
