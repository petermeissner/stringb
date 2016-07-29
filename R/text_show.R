#' showing text
#'
#' shows text or portions of the text via cat and the usage of text_snippet()
#' @param x text to be shown
#' @param length number of characters to be shown
#' @param from show from ith character
#' @param to show up to ith character
#' @param coll should x be collapsed using newline character as binding?
#' @param wrap should text be wrapped, or wrapped to certain width, or wrapped
#'    by certain function
#' @param ... further arguments passed through to \link[base]{cat}
#' @export
text_show = function(x, length=500, from=NULL, to=NULL, coll=FALSE, wrap=FALSE, ...){
  UseMethod("text_show")
}

#' text_show default
#' @rdname text_show
#' @method text_show default
#' @export
text_show.default = function(x, length=500, from=NULL, to=NULL, coll=FALSE, wrap=FALSE, ...){
  tmp       <- text_snippet(x, length, from, to, coll)
  diff_char <- sum(nchar(x)) - sum(nchar(tmp)) > 0
  diff_sum  <- sum(nchar(x)) - sum(nchar(tmp))
  diff_note <- ifelse(diff_char, paste0("\n[... ", format(diff_sum, big.mark = " "), " characters not shown]"),"")
  if(wrap==FALSE){
    cat( tmp, diff_note)
  }else if(is.function(wrap)){
    cat(wrap(tmp), diff_note)
  }else{
    cat( unlist(strsplit(tmp, " ")), diff_note, fill=wrap, ...)
  }
}
