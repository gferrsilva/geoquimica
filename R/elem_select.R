#' Select elements by the proportion of non-censured values
#'
#' @param df (data.frame): a 'data.frame' or flat object with numerical variables
#' @param cut (double): A number <default = 0.75>, generally lower than 1, to be multiplied to the lower detection limit value.
#' @param ... (ellipsis): any additional variable;
#'
#' @return data.frame
#' @export
#'
elem_select <- function(df, cut = .75, ...) {
  if (!is.numeric(cut)) {
    stop('"cut" must be a numeric value')
  }
  if (cut > 1) {
    warning('"cut" value greather than 1. It will be assumed that `cut` value is in percentage.')
    return(df %>%
      dplyr::select_if(~ sum(!is.na(.x)) >= (cut / 100 * nrow(df))))
  } else {
    return(df %>%
      dplyr::select_if(~ sum(!is.na(.x)) >= (cut * nrow(df))))
  }
}
