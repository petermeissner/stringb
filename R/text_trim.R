#' trim spaces
#' @param string text to be trimmed
#' @param pattern regex to look for
#' @export
text_trim <- function(string, pattern=" "){
  UseMethod("text_locate")
}

#' trim spaces default method
#' @rdname text_trim
#' @method text_trim default
#' @export
text_trim.default <- function(string, pattern=" "){

}
