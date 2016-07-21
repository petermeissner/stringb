#' wrapper function of eval() and parse() to evaluate character vector
#' @param x character vector to be parsed and evaluated
#' @param envir where to evaluate character vector
#' @param ... arguments passed through to eval()
#' @export
text_eval <- function(x, envir=parent.frame(), ...){
  eval(
    parse(text = x), 
    envir = envir, 
    ...
  )
}