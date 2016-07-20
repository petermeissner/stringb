#' retrieving text snippet
#'
#' function will give back snippets of text via using length,
#' length and from, length and to, or from and to to specify the snippet
#' @param x character vector to be snipped
#' @param length length of snippet
#' @param from starting character
#' @param to last character
#' @param coll should a possible vector x with length > 1 collapsed with newline
#'    character as separator?
#' @describeIn text_snippet retrieving text snippet
#' @export
text_snippet <-function(x, length=max(nchar(x)), from=NULL, to=NULL, coll=FALSE){
  # input check
  stopifnot( length(length)!=0 | (length(from)!=0 & length(to)!=0) ) # any input
  # collapse before snipping?
  if(coll!=FALSE){
    if( identical(coll, TRUE) ){
      x <- paste0(x, collapse = "\n")
    }else{
      x <- paste0(x, collapse = coll)
    }
  }
  # snipping cases
  if( !is.null(from) & !is.null(to) ){                          # from + to
    return(substring(x, from, to))
  }else if( !is.null(from) & is.null(to) ){                     # from + length
    return(substring(x, from, from+length-1))
  }else if( is.null(from) & !is.null(to) ){                     # to + length
    return(substring(x, to-length, to))
  }else if( length(length)!=0 & is.null(from) & is.null(to) ){  # length
    return(substring(x, 0, length))
  }
}
