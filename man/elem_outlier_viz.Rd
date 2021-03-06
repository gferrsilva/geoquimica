% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/elem_outlier_viz.R
\name{elem_outlier_viz}
\alias{elem_outlier_viz}
\title{Visualize a histogram of data separating background and anomalous answer with a "ggplot2" object.}
\usage{
elem_outlier_viz(
  x,
  coef = 1.5,
  na.rm = FALSE,
  bins = NULL,
  binwidth = NULL,
  ...
)
}
\arguments{
\item{x}{(numeric): a numeric vector containing the data to detect the outliers}

\item{coef}{(numeric): A number, generally 1.5 ("first order anomaly"), 3.0 ("second order anomaly") or 4.5 ("thrid order anomaly"), indicating the coeficient to apply on the multiplication to determine the anomalous values.e}

\item{na.rm}{(logical): If TRUE, all NA values would be removed before the calculation.}

\item{bins}{(numeric): the number of bins in the histogram. If not provided, the plot will be drawn based on the binwidth argument or arbitrarily with 30 bins.}

\item{binwidth}{(numeric): the width of each bin. the plot will be drawn based on the bin argument or even arbitrarily with 30 bins.}

\item{...}{(ellipsis): any additional variable;}
}
\value{
plot ("ggplot2" object)
}
\description{
Visualize a histogram of data separating background and anomalous answer with a "ggplot2" object.
}
