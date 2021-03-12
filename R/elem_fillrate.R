#' Get the proportion of non missing values for each columns of a dataframe
#' This function returns  a two columns dataframe: column names and the non missing values proportion
#' @param df (data.frame): dataframe with any type of columns
#' @param sort (logical): if TRUE, R returns the object sorted by the fill rate (non NA proportion) in decreasing order b
#' @param ... (ellipses): any additional parameter.
#'
#' @return dataframe
#' @export
#'

elem_fillrate <- function(df, sort = FALSE, ...) {
  cols <- NULL
  clist <- data.frame(
    `Column.Name` = character(),
    `Fill.Rate` = double(),
    stringsAsFactors = FALSE
  )

  for (c in 1:ncol(df)) {
    cols[c] <- (100 * sum(!is.na(df[c])) / nrow(df[c]))
  }
  for (c in 1:ncol(df)) {
    clist[[c, 1]] <- paste0(names(df[c]))
    clist[[c, 2]] <- round(cols[[c]], digits = 2)
  }
  if (sort == FALSE) {
    return(clist)
  } else {
    return(clist %>% dplyr::arrange(dplyr::desc(Fill.Rate)))
  }
}
