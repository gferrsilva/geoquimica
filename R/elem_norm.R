
#' Normalize your data into the minmax or centered log ratio distribution
#'
#' @param df (data.frame): a data.frame object containing at least one numeric variable to be normalized.
#' @param method (character): the method choosen for normalization <default = minmax>. Must be one of the three options: "minmax" (defines a range greater than or equal to 0 and less than or equal to 1), "clr" (centered log ratio transformation) and "log10" (logarithm base 10).
#' @param keep (character): a character vector containing the names of numeric columns to be preserved of the normalization.
#'
#' @return data.frame
#' @export
#'
#' @examples elem_norm(df, method = "clr", keep = c("Identifier","UTM_E","UTM_N","LAT","LONG"))
elem_norm <- function(df, method = 'minmax', keep = NULL, ...) {

  if(sum(sapply(df, class) == 'numeric') == 0){
    stop('Input data.frame must contain at least one numeric variable!')
  }

  if(method == 'minmax'){
  normalize <- function(x) {
    return ((x - min(x, na.rm = TRUE)) / (max(x, na.rm = T) - min(x, na.rm = T)))
  }
  if(is.null(keep)){
    index <- names(df)
    dflabs <- df %>% purrr::discard(is.numeric)
    dfnum <- df %>% purrr::keep(is.numeric)
    dfnum <- tidyr::as_tibble(sapply(dfnum, normalize))
    df <- tidyr::as_tibble(cbind(dflabs, dfnum))
    return(df %>%
      dplyr::select(all_of(index)))
  } else {
    index <- names(df)
    k <- df %>%
      dplyr::select(all_of(keep))
    df <- df %>%
      dplyr::select(-all_of(keep))
    dflabs <- df %>% purrr::discard(is.numeric)
    dfnum <- df %>% purrr::keep(is.numeric)
    dfnum <- tidyr::as_tibble(sapply(dfnum, normalize))
    df <- tidyr::as_tibble(cbind(dflabs, k, dfnum))
    return(df %>%
      dplyr::select(all_of(index)))
  }
  }

if(method == 'clr'){

  if(is.null(keep)){
    index <- names(df)
    dflabs <- df %>% dplyr::discard(is.numeric)
    dfnum <- df %>% dplyr::keep(is.numeric)
    dfnum <- tidyr::as_tibble(sapply(dfnum, compositions::clr))
    df <- tidyr::as_tibble(cbind(dflabs, dfnum))
    return(df %>%
      select(all_of(index)))
  } else {
    index <- names(df)
    k <- df %>%
      select(all_of(keep))
    df <- df %>%
      select(-all_of(keep))
    dflabs <- df %>% discard(is.numeric)
    dfnum <- df %>% keep(is.numeric)
    dfnum <- as_tibble(sapply(dfnum, compositions::clr))
    df <- as_tibble(cbind(dflabs, k, dfnum))
    return(df %>%
      select(all_of(index)))
    }
}

if(method == 'log10'){
  if(is.null(keep)){
    index <- names(df)
    dflabs <- df %>% purrr::discard(is.numeric)
    dfnum <- df %>% purrr::keep(is.numeric)
    dfnum <- tidyr::as_tibble(sapply(dfnum, log10))
    df <- tidyr::as_tibble(cbind(dflabs, dfnum))
    return(df %>%
      dplyr::select(all_of(index)))
  } else {
    index <- names(df)
    k <- df %>%
      dplyr::select(all_of(keep))
    df <- df %>%
      dplyr::select(-all_of(keep))
    dflabs <- df %>% purrr::discard(is.numeric)
    dfnum <- df %>% purrr::keep(is.numeric)
    dfnum <- tidyr::as_tibble(sapply(dfnum, log10))
    df <- tidyr::as_tibble(cbind(dflabs, k, dfnum))
    return(df %>%
      dplyr::select(all_of(index)))
  }
}
}
