% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/search.R
\name{search_node}
\alias{search_node}
\title{Find element(s) in  apsimx file}
\usage{
search_node(l, all = FALSE, max_depth = 1e+06, case_insensitive = TRUE, ...)
}
\arguments{
\item{l}{The list of apsimx file}

\item{all}{Whether to find all elements}

\item{max_depth}{The maximum depth to search}

\item{case_insensitive}{Whether case sensitive}

\item{...}{Other names arguments for property to match}
}
\value{
A list matching all criteria if all equals to TRUE,
A list with node and path if all equals to FALSE (default)
}
\description{
Find element(s) in  apsimx file
}
\examples{
wheat <- read_apsimx(system.file("extdata/Wheat.json", package = "rapsimng"))
# Return empty list if not found
search_node(wheat, Name = "Simulations1")
# Find root level
a <- search_node(wheat, Name = "Simulations")
a$path
# Find sub-level
a <- search_node(wheat, Name = "Wheat")
a$path
a <- search_node(wheat, `$type` = "Models.PMF.Cultivar, Models")
a$path

# Find multiple attributes
a <- search_node(wheat,
            Name = 'PotentialBranchingRate',
            `$type` = "Models.Functions.PhaseLookup, Models")
a$path
a$node$Name
# Find all cultivar nodes
 a <- search_node(wheat, `$type` = "Models.PMF.Cultivar, Models", all = TRUE)
length(a)
}
