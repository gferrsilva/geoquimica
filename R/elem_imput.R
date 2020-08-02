#' Impute values lower than limit of detection by replacing it for the multiplication of coef*LOD
#'
#' @param df (data.frame): a data.frame containing the elements concentrations
#' @param coef (double): default = 0.5. A number, generally lower than 1, to be multiplied to the lower detection limit value.
#'
#' @return data.frame
#' @export
#'
#' @examples elem_imput(df, coef = 0.9)
elem_imput <- function(df, coef = 0.5, ...) {
  # Imputation in missing values
  require(dplyr)
  require(purrr)

  if(is.double(coef) == FALSE){
    stop('`coef` must be a numeric value')
  }
  if(coef > 1){
    warning('`coef` value greather than 1. "<LOD" values will be updated to a number greater than the detection limit')
  }

  index <- names(df)
  dflabs <- df %>% purrr::discard(is.numeric)
  dfnum <- df %>% purrr::keep(is.numeric)

  min.var <- {}

  for (i in 1:length(dfnum)) {
    min.var[i] <- min(dfnum[i], na.rm = TRUE)
  }

  for (i in 1:length(dfnum)) {
    dfnum[[i]] <- replace_na(dfnum[[i]], coef*min.var[[i]])
  }

  df <- tidyr::as_tibble(cbind(dflabs, dfnum))
  df %>%
    dplyr::select(all_of(index)) %>%
    dplyr::mutate_if(is.numeric, function(x) ifelse(is.infinite(x), NA, x))
}
