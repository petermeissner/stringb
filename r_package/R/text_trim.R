#' trim spaces
#' @param string text to be trimmed
#' @param pattern regex to look for
#' @param side defaults to both might also be left, right, both or b, r, l to
#'             express where to trim pattern away
#' @param ... further arguments passed through to text_replace()
#' @export
text_trim <- function(string, side=c("both","left","right"), pattern=" ", ...){
  UseMethod("text_trim")
}

#' trim spaces default
#' @rdname text_trim
#' @method text_trim default
#' @export
text_trim.default <- function(string, side=c("both","left","right"), pattern=" ", ... ){
  # sanatizing side
  stopifnot(all(side %in% c("both", "left", "right", "b", "l", "r")))
  side <- side[1]
  # pimping pattern to match series at start / end
  p_start <- paste0("^", pattern, "*")
  p_end   <- paste0(pattern, "*$")
  if(side == "both" | side == "b" | side=="left" | side=="l"){
    string <- text_replace(string, pattern = p_start, replacement = "", ...)
  }
  if(side == "both" | side == "b" | side=="right" | side=="r"){
    string <- text_replace(string, pattern = p_end, replacement = "", ...)
  }
  string
}


#' trim spaces list
#' @rdname text_trim
#' @method text_trim list
#' @export
text_trim.list <- function(string, side=c("both","left","right"), pattern=" ", ... ){
  lapply(string, text_trim, side=side, pattern=pattern, ...)
}


#' trim spaces numeric
#' @rdname text_trim
#' @method text_trim numeric
#' @export
text_trim.numeric <- function(string, side=c("both","left","right"), pattern=" ", ... ){
  text_trim(as.character(string), side=side, pattern=pattern, ...)
}








