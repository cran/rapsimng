% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/simulations.R
\name{get_simulations}
\alias{get_simulations}
\title{Get simulations for a factorial experiment}
\usage{
get_simulations(l)
}
\arguments{
\item{l}{A list from read_apsim with Factorial.Permutation as root.}
}
\value{
A list with Factor as name and Levels as values
}
\description{
Get simulations for a factorial experiment
}
\examples{
wheat <- read_apsimx(system.file("extdata/wheat.apsimx", package = "rapsimng"))
permutation <- search_path(wheat, path = "[Factors].Permutation")
get_simulations(permutation$node)
}
