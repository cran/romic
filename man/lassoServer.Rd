% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/module_lasso.R
\name{lassoServer}
\alias{lassoServer}
\title{Lasso Server}
\usage{
lassoServer(id, tomic, tomic_table)
}
\arguments{
\item{id}{An ID string that corresponds with the ID used to call the module's
UI function.}

\item{tomic}{Either a \code{tidy_omic} or \code{triple_omic} object}

\item{tomic_table}{A table taken from a tidy (i.e., augmented measurements)
or triple omic dataset}
}
\value{
A \code{tomic} object amended based on the lasso selection.
}
\description{
Take a subset of entries from a tomic table (generally selected using the
  lasso function) and then either filter a tomic object to these entries
  or tag the entries of interest with a user-specified variable.
}
