#' wrapper around nchar to return text length
#' @param x see \link{nchar}
#' @param type see \link{nchar}
#' @param allowNA see \link{nchar}
#' @param keepNA see \link{nchar}
#' @export
text_nchar <- function(x, type = "chars", allowNA = FALSE, keepNA = TRUE){
  nchar(x, type, allowNA, keepNA)
}

#' wrapper around nchar to return text length
#' @param x see \link{nchar}
#' @param type see \link{nchar}
#' @param allowNA see \link{nchar}
#' @param keepNA see \link{nchar}
#' @param na.rm see \link{nchar}
#' @export
text_length <- function(x, type = "chars", allowNA = FALSE, keepNA = TRUE, na.rm=FALSE){
  sum(text_nchar(x, type, allowNA, keepNA), na.rm=na.rm)
}
