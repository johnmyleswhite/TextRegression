\name{regress.text}
\alias{regress.text}
\title{Fit regularized regressions to text data given a corpus and outputs.}
\usage{
  regress.text(text, y, n.splits = 10, size = 0.8,
  standardizeCase = TRUE, stripSpace = TRUE,
  removeStopwords = TRUE)
}
\arguments{
  \item{text}{A character vector containing the documents
  for analysis.}

  \item{y}{A numeric vector of outputs associated with the
  documents.}

  \item{n.splits}{How many resampling steps should be used
  to set lambda?}

  \item{size}{How much of the data should be used during
  resampling for model fitting?}

  \item{standardizeCase}{Should all of the text be
  standardized on lowercase?}

  \item{stripSpace}{Should all whitespace be stripped from
  the text?}

  \item{removeStopwords}{Should tm's list of English
  stopwords be pulled out of the text?}
}
\value{
  A list containing regression coefficients, the terms used
  with those coefficients, the value of lambda used for
  model assessment, and an estimate of the RMSE associated
  with that model.
}
\description{
  This function will fit regularized regressions to text
  data given a corpus and outputs.
}
\examples{
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

