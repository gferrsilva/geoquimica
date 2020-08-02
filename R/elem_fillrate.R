#' Title Get the proportion of non missing values for each columns of a dataframe
#' This function returns  a two columns dataframe: column names and the non missing values proportion
#' @param df (data.frame): dataframe with any type of columns
#' @param sort (logical): if TRUE, R returns the object sorted by the fill rate (non NA proportion) in decreasing order b
#'
#' @return dataframe
#' @export
#'
#' @examples elem_fillrate(df, sort = TRUE)
elem_fillrate <- function(df, sort = F, ...) {
  require(dplyr)
  cols <- NULL
  clist <- data.frame(`Column.Name`= character(),
                      `Fill.Rate` = double(),
                      stringsAsFactors = F)

  for (c in 1:ncol(df)) {
    cols[c] <- (100*sum(!is.na(df[c]))/nrow(df[c]))
  }
  for (c in 1:ncol(df)) {
    clist[[c,1]]  <- paste0(names(df[c]))
    clist[[c,2]] <- round(cols[[c]],digits = 2)
  }
  if (sort == F) {
    return(clist)
  } else {
    return(clist %>% dplyr::arrange(desc(Fill.Rate)))
  }
}
