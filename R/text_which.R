#' generic function to know in which elements a pattern can be found
#' @param string the text to be searched through
#' @param pattern regex to look for
#' @param ... further arguments passed through to \link[base]{grepl}
#' @export
text_which <- function(string, pattern, ...){
  UseMethod("text_which")
}


#' text_which default method
#' @rdname text_which
#' @method text_which default
#' @export
text_which.default <- function(string, pattern, ...){
  grep(pattern=pattern, x=string, ...)
}

#' generic function to know in which elements a pattern can be found
#' @rdname text_which
#' @export
text_grep <- function(string, pattern, ...){
  UseMethod("text_which")
}


#' generic function to get whole elements in which pattern was found
#' @param string the character vector to be searched through
#' @param pattern regex to look for
#' @param ... further arguments passed through to \link[base]{grep}
#' @export
text_which_value <- function(string, pattern, ...){
  UseMethod("text_which_value")
}

#' generic function to get whole elements in which pattern was found
#' @rdname text_which_value
#' @export
text_grepv <- function(string, pattern, ...){
  UseMethod("text_which_value")
}

#' text_which_value default method
#' @rdname text_which_value
#' @method text_which_value default
#' @export
text_which_value.default <- function(string, pattern, ...){
  grep(pattern=pattern, x=string, value=TRUE, ...)
}


#' generic for subsetting/filtering vectors
#' @param string text to be subsetted
#' @param pattern regular expression to subset by
#' @param ... further arguments passed through to \link[base]{grep}
#' @export
text_subset <- function(string, pattern, ...){
  UseMethod("text_which_value")
}

#' generic for subsetting/filtering vectors
#' @param string text to be subsetted
#' @param pattern regular expression to subset by
#' @param ... further arguments passed through to \link[base]{grep}
#' @export
text_filter <- function(string, pattern, ...){
  UseMethod("text_which_value")
}
















