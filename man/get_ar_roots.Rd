% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/pickAndChangeParams.R
\name{get_ar_roots}
\alias{get_ar_roots}
\title{Calculate absolute values of the roots of the AR characteristic polynomials}
\usage{
get_ar_roots(gsmar)
}
\arguments{
\item{gsmar}{a class 'gsmar' object, typically generated by \code{fitGSMAR} or \code{GSMAR}.}
}
\value{
Returns a list with \code{M} elements each containing the absolute values of the roots
 of the AR characteristic polynomial corresponding to each mixture component.
}
\description{
\code{get_ar_roots} calculates the absolute values of the roots of the AR
  characteristic polynomials for each mixture component.
}
\examples{
params12 <- c(1.70, 0.85, 0.30, 4.12, 0.73, 1.98, 0.63)
gmar12 <- GSMAR(data=simudata, p=1, M=2, params=params12, model="GMAR")
get_ar_roots(gmar12)
}
\references{
\itemize{
   \item Kalliovirta L., Meitz M. and Saikkonen P. 2015. Gaussian Mixture Autoregressive model for univariate time series.
           \emph{Journal of Time Series Analysis}, \strong{36}(2), 247-266.
   \item Meitz M., Preve D., Saikkonen P. 2023. A mixture autoregressive model based on Student's t-distribution.
         \emph{Communications in Statistics - Theory and Methods}, \strong{52}(2), 499-515.
   \item Virolainen S. 2022. A mixture autoregressive model based on Gaussian and Student's t-distributions.
         Studies in Nonlinear Dynamics & Econometrics, \strong{26}(4) 559-580.
 }
}
