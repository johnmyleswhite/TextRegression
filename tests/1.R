library('TextRegression')
library('testthat')

text <- c('this is text',
          'this is more text',
          'both contained some text',
          'text is good',
          'and more text is better',
          'but endless text is best',
          'one day we will have enough text',
          'until then we can only hope',
          'in the text valhalla there are no stopwords',
          'and draughts of text flow from the castle walls')

documents <- data.frame(Text = text)
row.names(documents) <- 1:nrow(documents)

corpus <- Corpus(DataframeSource(documents))
corpus <- tm_map(corpus, tolower)
corpus <- tm_map(corpus, stripWhitespace)
corpus <- tm_map(corpus, removeWords, stopwords('english'))

dtm <- DocumentTermMatrix(corpus)

x <- dtm.to.Matrix(dtm)

for (i in 1:3)
{
	set.seed(i)

  beta <- rnorm(ncol(x), 0, 10)
  beta[sample(1:ncol(x), ncol(x) - 1, replace = FALSE)] <- 0
  
  intercept <- 100
  
  y <- x %*% beta + intercept + rnorm(nrow(x), 0, 0.0001)
  
  results <- regress.text(text, y)
  errors <- abs(results$coefficients - c(intercept, beta))
  
  print(paste(i, max(errors)))
  
  expect_that(max(errors) < 10, is_true())
  expect_that(length(results$coefficients) == length(results$terms), is_true())
}
# What else should be tested?
