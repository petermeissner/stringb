#' wraping text to specified width
#'
#' @param string text to be wrapped
#' @param ... further arguments passed through to \link[base]{strwrap}
#' @seealso \link[base]{strwrap}
#' @export
text_wrap = function(string, ...){
  UseMethod("text_wrap")
}

#' text_wrap default
#' @rdname text_wrap
#' @method text_wrap default
#' @export
text_wrap.default = function(string, ...){
  strwrap(string)
}
