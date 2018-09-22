% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/pickAndChangeParams.R
\name{get_ar_roots}
\alias{get_ar_roots}
\title{Calculate absolute values of the roots of the AR characteristic polynomials}
\usage{
get_ar_roots(gsmar)
}
\arguments{
\item{gsmar}{object of class \code{'gsmar'}, generated by function \code{fitGSMAR()} or \code{GSMAR()}.}
}
\value{
Returns a list with \code{M} elements each containing the absolute values of the roots
 of the AR characteristic polynomial corresponding to each mixture component.
}
\description{
\code{get_ar_roots} calculates absolute values of the roots of the AR characteristic polynomials
  for each component.
}
\examples{
params13 <- c(1.4, 0.88, 0.26, 2.46, 0.82, 0.74, 5.0, 0.68, 5.2, 0.72, 0.2)
gmar13 <- GSMAR(data=VIX, p=1, M=3, params=params13, model="GMAR")
get_ar_roots(gmar13)
}
\references{
\itemize{
   \item Kalliovirta L., Meitz M. and Saikkonen P. 2015. Gaussian Mixture Autoregressive model for univariate time series.
           \emph{Journal of Time Series Analysis}, \strong{36}, 247-266.
   \item Meitz M., Preve D., Saikkonen P. 2018. A mixture autoregressive model based on Student's t-distribution.
           arXiv:1805.04010 \strong{[econ.EM]}.
   \item There are currently no published references for G-StMAR model, but it's a straightforward generalization with
           theoretical properties similar to GMAR and StMAR models.
 }
}