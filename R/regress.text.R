#' Fit regularized regressions to text data given a corpus and outputs.
#'
#' This function will fit regularized regressions to text data given
#' a corpus and outputs.
#'
#' @param text A character vector containing the documents for analysis.
#' @param y A numeric vector of outputs associated with the documents.
#' @param n.splits How many resampling steps should be used to set lambda?
#' @param size How much of the data should be used during resampling for model fitting?
#' @param standardizeCase Should all of the text be standardized on lowercase?
#' @param stripSpace Should all whitespace be stripped from the text?
#' @param removeStopwords Should tm's list of English stopwords be pulled out of the text?
#'
#' @return A list containing regression coefficients, the terms used with those coefficients, the value of lambda used for model assessment, and an estimate of the RMSE associated with that model.
#'
#' @export
#'
#' @examples
#' library('TextRegression')
#'
#' text <- c('saying text is good',
#'           'saying text once and saying text twice is better',
#'           'saying text text text is best',
#'           'saying text once is still ok',
#'           'not saying it at all is bad',
#'           'because text is a good thing',
#'           'we all like text',
#'           'even though sometimes it is missing')
#' 
#' y <- c(1, 2, 3, 1, 0, 1, 1, 0)
#' 
#' results <- regress.text(text, y)
#' 
#' print(results)
regress.text <- function(text,
                         y,
                         n.splits = 10,
                         size = 0.8,
                         standardizeCase = TRUE,
                         stripSpace = TRUE,
                         removeStopwords = TRUE)
{
  # Fit regularized regressions to text data given corpus and outputs.
  # Provide text documents as vector x.
  # Provide outputs as vector y.
  # In future, allow specification of directory with corpus in files.
  # Allow control of preprocessing of text.
  # Allow control of L1 or L2 regularization.
  # Allow control of amount of resampling for hyperparameter tuning.

  # Do you want coefficients as output?
  # Do you want RMSE on test data?
  documents <- data.frame(Text = text)
  row.names(documents) <- 1:nrow(documents)
  
  corpus <- Corpus(DataframeSource(documents))
  
  if (standardizeCase)
  {
    corpus <- tm_map(corpus, tolower)
  }
  if (stripSpace)
  {
    corpus <- tm_map(corpus, stripWhitespace)
  }
  if (removeStopwords)
  {
    corpus <- tm_map(corpus, removeWords, stopwords('english'))
  }
  
  dtm <- DocumentTermMatrix(corpus)
  
  x <- dtm.to.Matrix(dtm)
  
  y <- as.vector(y)
  
  regularized.fit <- glmnet(x, y)
  
  lambdas <- regularized.fit$lambda
  
  # Calculate number of splits based on time required to perform original model fit.
  # Or based on data set size?
  
  performance <- data.frame()
  
  for (i in 1:n.splits)
  {
    indices <- sample(1:nrow(x), round(size * nrow(x)))

    training.x <- x[indices, ]
    training.y <- y[indices]
    test.x <- x[-indices, ]
    test.y <- y[-indices]
    
    for (lambda in lambdas)
    {
      resampling.fit <- glmnet(training.x, training.y)
      predicted.y <- as.numeric(predict(resampling.fit, newx = test.x, s = lambda))
      rmse <- sqrt(mean((predicted.y - test.y) ^ 2))
      performance <- rbind(performance, data.frame(Split = i, Lambda = lambda, RMSE = rmse))
    }
  }
  
  mean.rmse <- ddply(performance,
                     'Lambda',
                     function (df)
                     {
                       with(df, data.frame(RMSE = mean(RMSE)))
                     })
 
  optimal.lambda <- with(mean.rmse, max(Lambda[which(RMSE == min(RMSE))]))
  optimal.rmse <- with(subset(mean.rmse, Lambda == optimal.lambda), RMSE)
  
  coefficients <- as.numeric(coef(regularized.fit, s = optimal.lambda)[, 1])
  terms <- c('(Intercept)', colnames(dtm))
  
  return(list(coefficients = coefficients,
              terms = terms,
              lambda = optimal.lambda,
              rmse = optimal.rmse))
}
