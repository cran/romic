% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/app_pcs.R
\name{app_pcs}
\alias{app_pcs}
\title{PC Plot}
\usage{
app_pcs(tomic)
}
\arguments{
\item{tomic}{Either a \code{tidy_omic} or \code{triple_omic} object}
}
\value{
A \code{shiny} app
}
\description{
Generate a Shiny interactive scatter plot which allows visualization of
features, measurements, and samples (with principal components added).
}
\examples{
if (interactive()) {
  app_pcs(brauer_2008_tidy)
}
}
