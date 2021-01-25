#' padding text to specified width
#'
#' @param string text to be wrapped
#' @param width width text should have after padding; defaults to: max(nchar(string))
#' @param pad the character or character sequence to use for padding
#' @param side one of: c("left", "right", "both", "l", "r", "b", 1, 2, 3)
#' @export
text_pad <-
  function(
    string,
    width = max(nchar(string)),
    pad   = " ",
    side  = c("left", "right", "both", "l", "r", "b", 1, 2, 3)
  )
{
  UseMethod("text_pad")
}

#' text_wrap default
#' @rdname text_pad
#' @method text_pad default
#' @export
text_pad.default <-
  function(
    string,
    width = max(nchar(string)),
    pad   = " ",
    side  = c("left", "right", "both", "l", "r", "b", 1, 2, 3)
  )
{
  # input checks
  side <- side[1]
  stopifnot(side %in% c("left", "right", "both", "l", "r", "b", 1, 2, 3))
  if(side %in% c("left",  "l")){
    side <- 1
  }else if(side %in% c("right", "r")){
    side <- 2
  }else if(side %in% c("both",  "b")){
    side <- 3
  }
  # doing-duty-to-do
  if(side < 3 ){
    if( nchar(pad)==1 ){
      tmp <- text_dup(pad, width-nchar(string), vectorize = TRUE)$t
    }else{
      tmp <- text_snippet(text_dup(pad, width), length = width - nchar(string) )
    }
  }else{
    if( nchar(pad) == 1){
      tmpl <- text_dup(pad, floor(width-nchar(string)), vectorize = TRUE)$t
      tmpr <- text_dup(pad, ceiling(width-nchar(string)), vectorize = TRUE)$t
    }else{
      tmpl <- text_snippet(text_dup(pad, width), length = floor((width - nchar(string))/2) )
      tmpr <- text_snippet(text_dup(pad, width), length = ceiling((width - nchar(string))/2) )
    }
  }
  # return
  if(side == 1 ){
    return( text_c(tmp, string) )
  }
  if(side == 2 ){
    return( text_c(string, tmp) )
  }
  if(side == 3){
    return( text_c(tmpl, string, tmpr) )
  }
}
