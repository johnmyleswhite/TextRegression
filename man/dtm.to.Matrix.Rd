\name{dtm.to.Matrix}
\alias{dtm.to.Matrix}
\title{Transform a tm-style DTM into a sparse Matrix.}
\usage{
  dtm.to.Matrix(dtm)
}
\arguments{
  \item{dtm}{A document term matrix of class
  'DocumentTermMatrix'.}
}
\value{
  A sparse matrix (of class 'Matrix') representation of the
  DTM.
}
\description{
  Transform a DTM produced by the tm package into a sparse
  Matrix for use with the glmnet package.
}
\examples{
\dontrun{dtm.to.Matrix(dtm)}
}

