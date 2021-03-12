#' Detect univariate outlier by boxplot method.
#'
#' @param x (numerical): Input data. Must be a numerical array, generally containg concentration values, on which should be detected the anomalous values.
#' @param coef (numerical): A number, generally 1.5 ("first order anomaly"), 3.0 ("second order anomaly") or 4.5 ("thrid order anomaly"), indicating the coeficient to apply on the multiplication to determine the anomalous values.
#' @param na.rm (logical): If TRUE, all NA values would be removed before the calculation.
#' @param ... (ellipsis): any additional variable;
#'
#' @return factor with 3 levels: background, outlier and missing.
#' @export
#'
elem_detect_outlier <- function(x, coef = 1.5, na.rm = FALSE, ...) {
  if (!is.numeric(coef)) {
    stop('coef must be a numeric value, 1.5 ("first order anomaly"), 3.0 ("second order anomaly") or 4.5 ("thrid order anomaly")')
  }
  if (is.numeric(x)) {
    q1 <- stats::fivenum(x, na.rm = na.rm)[2]
    q3 <- stats::fivenum(x, na.rm = na.rm)[4]
    iqr <- q3 - q1
    tidyr::as_tibble(x) %>%
      dplyr::mutate(class = dplyr::case_when(
        is.na(.) ~ "missing",
        x >= (q1 - coef * iqr) & x <= (q3 + coef * iqr) ~ "background",
        TRUE ~ "outlier"
      )) %>%
      dplyr::pull(var = "class") %>%
      as.factor()
  } else {
    stop('"x" must be a numeric 1d array')
  }
}
