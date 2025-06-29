% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/quantileResiduals.R
\name{quantile_residuals_int}
\alias{quantile_residuals_int}
\title{Compute quantile residuals of GMAR, StMAR, or G-StMAR model}
\usage{
quantile_residuals_int(
  data,
  p,
  M,
  params,
  model = c("GMAR", "StMAR", "G-StMAR"),
  restricted = FALSE,
  constraints = NULL,
  parametrization = c("intercept", "mean")
)
}
\arguments{
\item{data}{a numeric vector or class \code{'ts'} object containing the data. \code{NA} values are not supported.}

\item{p}{a positive integer specifying the autoregressive order of the model.}

\item{M}{\describe{
  \item{For \strong{GMAR} and \strong{StMAR} models:}{a positive integer specifying the number of mixture components.}
  \item{For \strong{G-StMAR} models:}{a size \eqn{(2\times 1)} integer vector specifying the number of \emph{GMAR type} components \code{M1} in the
   first element and \emph{StMAR type} components \code{M2} in the second element. The total number of mixture components is \code{M=M1+M2}.}
}}

\item{params}{a real valued parameter vector specifying the model.
 \describe{
   \item{For \strong{non-restricted} models:}{
     Size \eqn{(M(p+3)+M-M1-1\times 1)} vector \strong{\eqn{\theta}}\eqn{=}(\strong{\eqn{\upsilon_{1}}}\eqn{,...,}\strong{\eqn{\upsilon_{M}}},
     \eqn{\alpha_{1},...,\alpha_{M-1},}\strong{\eqn{\nu}}) where
     \itemize{
       \item \strong{\eqn{\upsilon_{m}}}\eqn{=(\phi_{m,0},}\strong{\eqn{\phi_{m}}}\eqn{,}\eqn{\sigma_{m}^2)}
       \item \strong{\eqn{\phi_{m}}}\eqn{=(\phi_{m,1},...,\phi_{m,p}), m=1,...,M}
       \item \strong{\eqn{\nu}}\eqn{=(\nu_{M1+1},...,\nu_{M})}
       \item \eqn{M1} is the number of GMAR type regimes.
     }
     In the \strong{GMAR} model, \eqn{M1=M} and the parameter \strong{\eqn{\nu}} dropped. In the \strong{StMAR} model, \eqn{M1=0}.

     If the model imposes \strong{linear constraints} on the autoregressive parameters:
     Replace the vectors \strong{\eqn{\phi_{m}}} with the vectors \strong{\eqn{\psi_{m}}} that satisfy
      \strong{\eqn{\phi_{m}}}\eqn{=}\strong{\eqn{C_{m}\psi_{m}}} (see the argument \code{constraints}).
     }
   \item{For \strong{restricted} models:}{
     Size \eqn{(3M+M-M1+p-1\times 1)} vector \strong{\eqn{\theta}}\eqn{=(\phi_{1,0},...,\phi_{M,0},}\strong{\eqn{\phi}}\eqn{,}
     \eqn{\sigma_{1}^2,...,\sigma_{M}^2,}\eqn{\alpha_{1},...,\alpha_{M-1},}\strong{\eqn{\nu}}), where \strong{\eqn{\phi}}=\eqn{(\phi_{1},...,\phi_{p})}
     contains the AR coefficients, which are common for all regimes.

     If the model imposes \strong{linear constraints} on the autoregressive parameters:
     Replace the vector \strong{\eqn{\phi}} with the vector \strong{\eqn{\psi}} that satisfies
      \strong{\eqn{\phi}}\eqn{=}\strong{\eqn{C\psi}} (see the argument \code{constraints}).
   }
 }
 Symbol \eqn{\phi} denotes an AR coefficient, \eqn{\sigma^2} a variance, \eqn{\alpha} a mixing weight, and \eqn{\nu} a degrees of
 freedom parameter. If \code{parametrization=="mean"}, just replace each intercept term \eqn{\phi_{m,0}} with the regimewise mean
 \eqn{\mu_m = \phi_{m,0}/(1-\sum\phi_{i,m})}. In the \strong{G-StMAR} model, the first \code{M1} components are \emph{GMAR type}
 and the rest \code{M2} components are \emph{StMAR type}.
 Note that in the case \strong{M=1}, the mixing weight parameters \eqn{\alpha} are dropped, and in the case of \strong{StMAR} or \strong{G-StMAR} model,
 the degrees of freedom parameters \eqn{\nu} have to be larger than \eqn{2}.}

\item{model}{is "GMAR", "StMAR", or "G-StMAR" model considered? In the G-StMAR model, the first \code{M1} components
are \emph{GMAR type} and the rest \code{M2} components are \emph{StMAR type}.}

\item{restricted}{a logical argument stating whether the AR coefficients \eqn{\phi_{m,1},...,\phi_{m,p}} are restricted
to be the same for all regimes.}

\item{constraints}{specifies linear constraints imposed to each regime's autoregressive parameters separately.
\describe{
\item{For \strong{non-restricted} models:}{a list of size \eqn{(p \times q_{m})} constraint matrices \strong{\eqn{C_{m}}} of full column rank
  satisfying \strong{\eqn{\phi_{m}}}\eqn{=}\strong{\eqn{C_{m}\psi_{m}}} for all \eqn{m=1,...,M}, where
  \strong{\eqn{\phi_{m}}}\eqn{=(\phi_{m,1},...,\phi_{m,p})} and \strong{\eqn{\psi_{m}}}\eqn{=(\psi_{m,1},...,\psi_{m,q_{m}})}.}
\item{For \strong{restricted} models:}{a size \eqn{(p\times q)} constraint matrix \strong{\eqn{C}} of full column rank satisfying
  \strong{\eqn{\phi}}\eqn{=}\strong{\eqn{C\psi}}, where \strong{\eqn{\phi}}\eqn{=(\phi_{1},...,\phi_{p})} and
  \strong{\eqn{\psi}}\eqn{=\psi_{1},...,\psi_{q}}.}
}
The symbol \eqn{\phi} denotes an AR coefficient. Note that regardless of any constraints, the autoregressive order
is always \code{p} for all regimes.
Ignore or set to \code{NULL} if applying linear constraints is not desired.}

\item{parametrization}{is the model parametrized with the "intercepts" \eqn{\phi_{m,0}} or
"means" \eqn{\mu_{m} = \phi_{m,0}/(1-\sum\phi_{i,m})}?}
}
\value{
Returns a \eqn{(Tx1)} numeric vector containing the quantile residuals of the specified GMAR, StMAR or G-StMAR model.
 Note that there are no quantile residuals for the first \code{p} observations as they are the initial values.
}
\description{
\code{quantile_residuals_int} computes the quantile residuals of the specified GMAR, StMAR, or G-StMAR model.
}
\details{
Numerical integration is employed if the quantile residuals cannot be obtained analytically with the
 hypergeometric function using the package 'gsl'.
}
\references{
\itemize{
   \item Galbraith, R., Galbraith, J. 1974. On the inverses of some patterned matrices arising
           in the theory of stationary time series. \emph{Journal of Applied Probability} \strong{11}, 63-71.
   \item Kalliovirta L. (2012) Misspecification tests based on quantile residuals.
           \emph{The Econometrics Journal}, \strong{15}, 358-393.
   \item Kalliovirta L., Meitz M. and Saikkonen P. 2015. Gaussian Mixture Autoregressive model for univariate time series.
           \emph{Journal of Time Series Analysis}, \strong{36}(2), 247-266.
   \item Meitz M., Preve D., Saikkonen P. 2023. A mixture autoregressive model based on Student's t-distribution.
         \emph{Communications in Statistics - Theory and Methods}, \strong{52}(2), 499-515.
   \item Virolainen S. 2022. A mixture autoregressive model based on Gaussian and Student's t-distributions.
         Studies in Nonlinear Dynamics & Econometrics, \strong{26}(4) 559-580.
 }
}
\keyword{internal}
