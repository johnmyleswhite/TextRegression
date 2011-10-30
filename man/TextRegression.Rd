\docType{package}
\name{TextRegression}
\alias{"package-TextRegression"}
\alias{TextRegression}
\title{Predict continuous valued outputs associated with text documents.}
\description{
  Predict continuous valued outputs associated with text
  documents. The input corpus of text documents is
  transformed into a document-term matrix (DTM) and then a
  regularized linear regression is fit that uses this
  matrix as predictors to predict the continuous valued
  output. The corpus's terms, coefficients for all terms
  and an estimate of the model's predictive power are
  returned in a list.
}
\examples{
library('TextRegression')

library('TextRegression')

text <- c('saying text is good',
'saying text once and saying text twice is better',
'saying text text text is best',
'saying text once is still ok',
'not saying it at all is bad',
'because text is a good thing',
'we all like text',
'even though sometimes it is missing')

y <- c(1, 2, 3, 1, 0, 1, 1, 0)

results <- regress.text(text, y)

print(results)
}
\references{
  This code is inspired by Noah Smith's work.
}

