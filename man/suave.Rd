% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/suave.R
\name{suave}
\alias{suave}
\title{Integration with SUbregion-Adaptive Vegas Algorithm}
\usage{
suave(f, nComp = 1L, lowerLimit, upperLimit, ..., relTol = 1e-05,
  absTol = 0, minEval = 0L, maxEval = 10^6, flags = list(verbose =
  1, final = 1, smooth = 1, keep_state = 0, load_state = 0, level = 0,
  rngSeed = 12345L), nVec = 1L, nNew = 1000L, nMin = 50L,
  flatness = 50, stateFile = NULL)
}
\arguments{
\item{f}{The function (integrand) to be integrated as in \code{\link{cuhre}}. Optionally, the
function can take two additional arguments in addition to the
variable being integrated: - \code{cuba_weight} which is the
weight of the point being sampled, - \code{cuba_iter} the
current iteration number. The function author may choose to use
these in any appropriate way or ignore them altogether.}

\item{nComp}{The number of components of f, default 1, bears no
relation to the dimension of the hypercube over which
integration is performed.}

\item{lowerLimit}{The lower limit of integration, a vector for
hypercubes.}

\item{upperLimit}{The upper limit of integration, a vector for
hypercubes.}

\item{...}{All other arguments passed to the function f.}

\item{relTol}{The maximum tolerance, default 1e-5.}

\item{absTol}{the absolute tolerance, default 0.}

\item{minEval}{the minimum number of function evaluations required}

\item{maxEval}{The maximum number of function evaluations needed,
default 10^6.  Note that the actual number of function
evaluations performed is only approximately guaranteed not to
exceed this number.}

\item{flags}{flags governing the integration. A list with
components: - \code{verbose}: \code{verbose} encodes the
verbosity level, from 0 (default) to 3.  Level 0 does not print
any output, level 1 prints \dQuote{reasonable} information on
the progress of the integration, levels 2 and 3 echo the input
parameters.  - \code{final}: when \code{ 0}, all sets of
samples collected on a subregion during the various iterations
or phases contribute to the final result.  When \code{ 1}, only
the last (largest) set of samples is used in the final result.
- \code{smooth}. When \code{smooth = 0}, apply additional
smoothing to the importance function, this moderately improves
convergence for many integrands.  When \code{smooth = 1} , use
the importance function without smoothing, this should be
chosen if the integrand has sharp edges.  - \code{keep_state}:
when nonzero, retain state file if argument \code{stateFile} is
non-null.  - \code{load_state}: when zero, load state file if
found; if nonzero, reset state regardless - \code{level}: when
\code{0}, Mersenne Twister random numbers are used. When
nonzero Ranlux random numbers are used.  - \code{rngSeed}: When
zero, Sobol quasi-random numbers are used for
sampling. Otherwise the seed is used for the generator
indicated by \code{level}.}

\item{nVec}{the number of vectorization points, default 1, but can
be set to an integer > 1 for vectorization, for example, 1024
and the function f above needs to handle the vector of points
appropriately. See vignette examples.}

\item{nNew}{the number of new integrand evaluations in each
subdivision.}

\item{nMin}{the minimum number of samples a former pass must
contribute to a subregion to be considered in that region’s
compound integral value. Increasing nmin may reduce jumps in
the \eqn{\chi^2}{Chi2} value.}

\item{flatness}{the parameter p, or the type of norm used to
compute the fluctuation of a sample. This determines how
prominently ‘outliers,’ i.e. individual samples with a large
fluctuation, figure in the total fluctuation, which in turn
determines how a region is split up. As suggested by its name,
flatness should be chosen large for ‘flat’ integrands and small
for ‘volatile’ integrands with high peaks. Note that since
flatness appears in the exponent, one should not use too large
values (say, no more than a few hundred) lest terms be
truncated internally to prevent overflow.}

\item{stateFile}{the name of an external file. Vegas can store its
entire internal state (i.e. all the information to resume an
interrupted integration) in an external file.  The state file
is updated after every iteration. If, on a subsequent
invocation, Vegas finds a file of the specified name, it loads
the internal state and continues from the point it left
off. Needless to say, using an existing state file with a
different integrand generally leads to wrong results. Once the
integration finishes successfully, i.e. the prescribed accuracy
is attained, the state file is removed. This feature is useful
mainly to define \sQuote{check-points} in long-running
integrations from which the calculation can be restarted.}
}
\description{
Suave uses \code{\link{vegas}}-like importance sampling combined with a
globally adaptive subdivision strategy: Until the requested accuracy is
reached, the region with the largest error at the time is bisected in the
dimension in which the fluctuations of the integrand are reduced most. The
number of new samples in each half is prorated for the fluctuation in that
half.
}
\details{
See details in the documentation.
}
\examples{

integrand <- function(arg) {
  x <- arg[1]
  y <- arg[2]
  z <- arg[3]
  ff <- sin(x)*cos(y)*exp(z);
return(ff)
} # end integrand
suave(integrand, lowerLimit = rep(0, 3), upperLimit = rep(1, 3),
             relTol=1e-3,  absTol=1e-12,
             flags=list(verbose=2, final=0))

}
\references{
T. Hahn (2005) CUBA-a library for multidimensional numerical
integration. \emph{Computer Physics Communications}, \bold{168}, 78-95.
}
\seealso{
\code{\link{cuhre}}, \code{\link{divonne}}, \code{\link{vegas}}
}
\keyword{math}
