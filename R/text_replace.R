#' replacing patterns in string
#' @param string text to be replaced
#' @param pattern regex to look for
#' @param replacement replacement for pattern found
#' @param recycle should arguments be recycled if lengths do not match?
#' @param ... further parameter passed through to sub
#' @export
text_replace <- function(string, pattern=NULL, replacement=NULL, ...){
  UseMethod("text_replace")
}

#' replacing patterns default
#' @rdname text_replace
#' @method text_replace default
#' @export
text_replace.default <-
  function(string, pattern=NULL, replacement=NULL, recycle=FALSE, ...){
    if( (length(pattern) > 1 | length(replacement) > 1) & recycle ){
      mapply(sub, x=string, pattern=pattern, replacement=replacement, ..., USE.NAMES = FALSE)
    }else{
      sub(pattern=pattern, replacement=replacement, x=string, ...)
    }
  }


#' replacing patterns in string
#' @param string text to be replaced
#' @param pattern regex to look for
#' @param replacement replacement for pattern found
#' @param recycle should arguments be recycled if lengths do not match?
#' @param ... further parameter passed through to gsub
#' @export
text_replace_all <- function(string, pattern=NULL, replacement=NULL, ...){
  UseMethod("text_replace_all")
}

#' replacing patterns default
#' @rdname text_replace_all
#' @method text_replace_all default
#' @export
text_replace_all.default <-
  function(string, pattern=NULL, replacement=NULL, recycle=FALSE, ...){
    if( (length(pattern) > 1 | length(replacement) > 1) & recycle ){
      mapply(gsub, x=string, pattern=pattern, replacement=replacement, ..., USE.NAMES = FALSE)
    }else{
      gsub(pattern=pattern, replacement=replacement, x=string, ...)
    }
}



#' deleting patterns in string
#' @param string text to be replaced
#' @param pattern regex to look for and delete
#' @param ... further parameter passed through to sub
#' @export
text_delete <- function(string, pattern=NULL, ...){
  UseMethod("text_delete")
}

#' deleting patterns in string
#' @rdname text_delete
#' @method text_delete default
#' @export
text_delete.default <- function(string, pattern=NULL, ...){
  text_replace(string = string, pattern = pattern, replacement="")
}
