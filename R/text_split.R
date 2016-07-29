#' generic splitting strings
#' @param string text to search through
#' @param pattern regex to search for
#' @param vectorize should function be used in vectorized mode, i.e. should a
#'    pattern with length larger than 1 be allowed and if so, should it be
#'    matched to lines (with recycling if needed) instead of using on element on
#'    all lines
#' @param ... further arguments passed through to \link[base]{gregexpr}
#' @export
text_split <- function(string, pattern, vectorize=FALSE, ...){
  UseMethod("text_split")
}

#' text_split defaul method
#' @rdname text_split
#' @method text_split default
#' @export
text_split.default <- function(string, pattern, vectorize=FALSE, ...){
  if(is.list(string)){
    splits  <- lapply(string, text_split, pattern=pattern, vectorize=vectorize, ...)
    return(splits)
  }
  if(!vectorize & length(pattern)>1){
    warning("text_split : length of pattern > 1, only first element will be used")
    pattern <- pattern[1]
  }
  if(vectorize){
    splits <-  mapply(strsplit, split=pattern, x=string)
    info   <- mapply(c, i=seq_along(string), p=seq_along(pattern), SIMPLIFY = FALSE)
    for(i in seq_along(splits)){
      splits[[i]] <-
        data.frame(
          splits[[i]],
          info[[i]][[1]],
          info[[i]][[2]]
        )
    }
    splits <- do.call(rbind, splits)
    rownames(splits) <- NULL
    names(splits)    <- c("t", "i", "p")
    return(splits)
  }else{
    splits <- strsplit(x=string, split=pattern, ...)
    return(splits)
  }
}


#' generic splitting strings into pieces of length n
#' @param string text to search through
#' @param n length of pieces
#' @param vectorize should function be used in vectorized mode, i.e. should a
#'    pattern with length larger than 1 be allowed and if so, should it be
#'    matched to lines (with recycling if needed) instead of using on element on
#'    all lines
#' @export
text_split_n <- function(string, n, vectorize=FALSE){
  UseMethod("text_split_n")
}

#' text_split_n defaul method
#' @rdname text_split_n
#' @method text_split_n default
#' @export
text_split_n.default <- function(string, n, vectorize=FALSE){
  if(!vectorize & length(n)>1){
    warning("text_split : length of pattern > 1, only first element will be used")
    n <- n[1]
  }
  if(vectorize){
    splits <- mapply(text_split_n, n=n, string=string)
    return(splits)
  }else{
    splits <- gregexpr(text_c(".{0,",n,"}"), string)
    splits <- regmatches(string, splits)
    return(splits)
  }
}


