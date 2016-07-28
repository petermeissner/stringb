#' generic for concatenating strings
#'
#'
#' @param ... one or more texts to be concatonated (see also \link[base]{paste})
#' @param sep separator between concatonated elements (see also \link[base]{paste})
#' @param coll if texts (not only there elements) are to be collapsed as well,
#'        how should the be separated (see also \link[base]{paste})
#' @seealso \link[stringb:grapes-..-grapes]{\%..\%} and \link[stringb:grapes-.-grapes]{\%.\%}
#' @export
text_c <- function(..., sep="", coll=NULL){
  UseMethod("text_c")
}

#' text_c default
#' @rdname text_c
#' @method text_c default
#' @export
text_c.default <- function(..., sep="", coll=NULL){
  paste(..., sep=sep, collapse=coll)
}

#' concatenating strings operator
#'
#' @param a first text
#' @param b second text
#' @seealso \link{text_c} (and \link[base]{paste})
#' @export
`%.%`   <- function(a,b) text_c(a, b, sep="")


#' concatenating strings
#'
#' @param a first text
#' @param b first text
#' @seealso \link{text_c} (and \link[base]{paste})
#' @export
`%..%`  <- function(a,b) text_c(a, b, sep=" ")
