#' Predict continuous valued outputs associated with text documents.
#'
#' Predict continuous valued outputs associated with text documents. The input
#' corpus of text documents is transformed into a document-term matrix (DTM)
#' and then a regularized linear regression is fit that uses this matrix as
#' predictors to predict the continuous valued output. The corpus's terms,
#' coefficients for all terms and an estimate of the model's predictive
#' power are returned in a list.
#'
#' @references This code is inspired by Noah Smith's work.
#' @docType package
#' @name TextRegression
#' @aliases TextRegression package-TextRegression
#' @examples
#' library('TextRegression')
#'
#' \dontrun{regress.text(text, y)}
NULL
