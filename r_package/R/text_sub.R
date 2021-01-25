#' generic for extracting characters sequences by position
#'
#' @param string text from which to extract character sequence
#' @param start first character position
#' @param end  last character position
#' @seealso \link{text_snippet}
#' @export
text_sub <- function(string, start=NULL, end = NULL){
  UseMethod("text_sub")
}


#' text_sub default
#' @rdname text_sub
#' @method text_sub default
#' @export
text_sub.default <- function(string, start=NULL, end = NULL){
  text_snippet(string, from=start, to=end)
}
