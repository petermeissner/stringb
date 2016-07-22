#' generic repeating text
#' @param string text to be repeated
#' @param times how many times shal string be repeated
#' @param vectorize should function be used in vectorized mode, i.e. should a
#'    pattern with length larger than 1 be allowed and if so, should it be
#'    matched to lines (with recycling if needed) instead of using on element on
#'    all lines
#' @param ...
#' @export
text_dup <- function(string, times, vectorize, ...){
  UseMethod("text_dup")
}

#' @export
#' @rdname text_dup
text_rep <- function(string, times, vectorize, ...){
  UseMethod("text_dup")
}


