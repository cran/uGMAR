% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/printMethods.R
\name{print.gsmarpred}
\alias{print.gsmarpred}
\title{print method for class 'gsmarpred' objects}
\usage{
\method{print}{gsmarpred}(x, ..., digits = 2)
}
\arguments{
\item{x}{object of class \code{'gsmarpred'} generated by \code{predict.gsmar()}.}

\item{...}{currectly not used.}

\item{digits}{number of decimals to print}
}
\description{
\code{print.gsmarpred} is print method for object generated
 by \code{predict.gsmar()}.
}
\examples{
 \donttest{
 # GMAR-model
 params12 <- c(1.12321, 0.90557, 0.29288, 4.53131,
               0.70309, 3.21154, 0.83888)
 gmar12 <- GSMAR(VIX, 1, 2, params12)
 pred <- predict(gmar12, n_ahead=10, plotRes=FALSE)
 pred
 print(pred, digits=3)
 }
}