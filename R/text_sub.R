#' generic for extracting characters sequences by position
#'
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
