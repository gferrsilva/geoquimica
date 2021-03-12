#' Visualize a histogram of data separating background and anomalous answer with a "ggplot2" object.
#'
#' @param x (numeric): a numeric vector containing the data to detect the outliers
#' @param coef (numeric): A number, generally 1.5 ("first order anomaly"), 3.0 ("second order anomaly") or 4.5 ("thrid order anomaly"), indicating the coeficient to apply on the multiplication to determine the anomalous values.e
#' @param na.rm (logical): If TRUE, all NA values would be removed before the calculation.
#' @param bins (numeric): the number of bins in the histogram. If not provided, the plot will be drawn based on the binwidth argument or arbitrarily with 30 bins.
#' @param binwidth (numeric): the width of each bin. the plot will be drawn based on the bin argument or even arbitrarily with 30 bins.
#' @param ... (ellipsis): any additional variable;
#'
#' @return plot ("ggplot2" object)
#' @export
#'
elem_outlier_viz <- function(x,
                             coef = 1.5,
                             na.rm = FALSE,
                             bins = NULL,
                             binwidth = NULL,
                             ...) {
  if (isTRUE(na.rm)) {
    x <- stats::na.omit(x)
  }
  q1 <- stats::fivenum(x, na.rm = na.rm)[2]
  q3 <- stats::fivenum(x, na.rm = na.rm)[4]
  iqr <- q3 - q1
  plot <- tidyr::as_tibble(x) %>%
    dplyr::mutate(class = dplyr::case_when(
      is.na(.) ~ "missing",
      x >= (q1 - coef * iqr) & x <= (q3 + coef * iqr) ~ "background",
      TRUE ~ "outlier"
    )) %>%
    ggplot2::ggplot(mapping = aes(x = value)) +
    ggplot2::geom_rect(xmin = q1 - coef * iqr, xmax = q3 + coef * iqr, ymin = -Inf, ymax = Inf, fill = "lightgreen", alpha = .05) +
    ggplot2::geom_histogram(mapping = aes(fill = class), bins = bins, binwidth = binwidth) +
    ggplot2::geom_vline(xintercept = q1 - coef * iqr, col = "red") +
    ggplot2::geom_vline(xintercept = q3 + coef * iqr, col = "red") +
    ggplot2::theme_bw()
  plot
}
