
<!-- README.md is generated from README.Rmd. Please edit that file -->

# pacta.portfolio.allocate <img src="man/figures/logo.png" align="right" width="120" />

<!-- badges: start -->

[![Lifecycle:
experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://lifecycle.r-lib.org/articles/stages.html#experimental)
[![CRAN
status](https://www.r-pkg.org/badges/version/pacta.portfolio.allocate)](https://CRAN.R-project.org/package=pacta.portfolio.allocate)
[![R-CMD-check](https://github.com/RMI-PACTA/pacta.portfolio.allocate/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/RMI-PACTA/pacta.portfolio.allocate/actions/workflows/R-CMD-check.yaml)
[![pacta.portfolio.allocate status
badge](https://rmi-pacta.r-universe.dev/badges/pacta.portfolio.allocate)](https://rmi-pacta.r-universe.dev/ui#package:pacta.portfolio.allocate)
<!-- badges: end -->

The goal of pacta.portfolio.allocate is to provide all the functions and
utilities required to run PACTA for investors (ie. PACTA on financial
portfolios containing equities or corporate bonds).

## Installation

You can install the development version of pacta.portfolio.allocate from
[GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("RMI-PACTA/pacta.portfolio.allocate")
```

## Using functions exported by `pacta.portfolio.allocate`

To run PACTA, the functions exported by `pacta.portfolio.allocate` must
be composed in particular configuration. These configurations are
maintained in a series of repositories, each containing the prefix
`workflow.*`.

For example, the transition monitor platform is fuelled by the workflow
found here: <https://github.com/RMI-PACTA/workflow.transition.monitor>

## Coming Soon

A workflow to allow analysts to easily run PACTA locally…
