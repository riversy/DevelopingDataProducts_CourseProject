###
# Reusable Parts
###

library(tm)
library(wordcloud)

# The list of valid books
books <<- list(
  "Moby Dick; or The Whale" = "melville",
  "Sense and Sensibility" = "austen"
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
getBookLines <- function(book){
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
}

###
# Get whole text of a book
###
getBookText <- function(book){
  book.lines <- getBookLines(book)
  paste(book.lines, collapse = " ")
}

getTermMatrixPerBook <- function(book, qty){
  text <- getBookText(book)
  getTermMatrix(text, qty)
}

getTermMatrixPerChapter <- function(book){
  
}

###
# Get term Matrix for piece of text
###
getTermMatrix <- function(text, qty) {

  corpus = Corpus(VectorSource(text))
  corpus = tm_map(corpus, content_transformer(tolower))
  corpus = tm_map(corpus, removePunctuation)
  corpus = tm_map(corpus, removeNumbers)
  corpus = tm_map(corpus, removeWords, stopwords("english"))

  myDTM =
    TermDocumentMatrix(
      corpus,
      control = list(minWordLength = 1)
    )

  m = as.matrix(myDTM)

  sorted <- sort(rowSums(m), decreasing = TRUE)
  sorted[1:qty]
}
