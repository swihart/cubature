
<!-- README.md is generated from the source: README.Rmd -->

# cubature

[![Travis-CI Build
Status](https://travis-ci.org/bnaras/cubature.svg?branch=master)](https://travis-ci.org/bnaras/cubature)
[![CRAN\_Status\_Badge](http://www.r-pkg.org/badges/version/cubature)](https://cran.r-project.org/package=cubature)
[![Coverage
Status](https://img.shields.io/codecov/c/github/bnaras/cubature/master.svg)](https://codecov.io/github/bnaras/cubature?branch=master)
[![](https://cranlogs.r-pkg.org/badges/cubature)](https://cloud.r-project.org/package=cubature)

Cubature is an R package for adaptive multivariate integration over
hypercubes using deterministic and Monte Carlo methods. The package
provides wrappers around two C libraries:

  - The cubature C library of [Steven G.
    Johnson](https://math.mit.edu/~stevenj/)
  - The Cuba C library of [Thomas
    Hahn](https://wwwth.mpp.mpg.de/members/hahn/)

Both scalar and vectorized interfaces are available for all routines. R
users will gain a lot by using the vectorization as demonstrated in the
included vignette.
