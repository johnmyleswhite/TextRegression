#' Transform a tm-style DTM into a sparse Matrix.
#'
#' Transform a DTM produced by the tm package into a sparse Matrix for use
#' with the glmnet package.
#'
#' @param dtm A document term matrix of class 'DocumentTermMatrix'.
#'
#' @return A sparse matrix (of class 'Matrix') representation of the DTM.
#'
#' @export
#'
#' @examples
#' \dontrun{dtm.to.Matrix(dtm)}
dtm.to.Matrix <- function(dtm)
{
  m <- Matrix(0, nrow = dtm$nrow, ncol = dtm$ncol, sparse = TRUE)
  
  for (index in 1:length(dtm$i))
  {
    m[dtm$i[index], dtm$j[index]] <- dtm$v[index]
  }
  
  return(m)
}
