#' generic function to test if a regex can be found within a string
#' @param string text to be searched through
#' @param pattern regex to look for
#' @param ... further arguments passed through to \link[base]{grepl}
#' @export
text_detect <- function(string, pattern, ...){
  UseMethod("text_detect")
}


#' text_detect default method
#' @rdname text_detect
#' @method text_detect default
#' @export
text_detect.default <- function(string, pattern, ...){
  grepl(pattern=pattern, x=string, ...)
}



#' generic function to test if a regex can be found within a string
#' @rdname text_detect
#' @export
text_grepl <- function(string, pattern, ...){
  UseMethod("text_detect")
}






