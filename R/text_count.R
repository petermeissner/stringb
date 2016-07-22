#' generic for counting pattern occurences
#' @param string text to search through
#' @param pattern regex to search for
#' @param vectorize should function be used in vectorized mode, i.e. should a
#'    pattern with length larger than 1 be allowed and if so, should it be
#'    matched to lines (with recycling if needed) instead of using on element on
#'    all lines
#' @param sum if true all element-wise counts will be summed up
#' @param ... further arguments passed through to \link[base]{gregexpr}
#' @export
text_count <- function(string, pattern, sum=FALSE, vectorize=FALSE, ...){
  UseMethod("text_count")
}

#' text_count defaul method
#' @rdname text_count
#' @method text_count default
#' @export
text_count.default <- function(string, pattern, sum=FALSE, vectorize=FALSE, ...){
  if(is.list(string)){
    tmp  <- lapply(string, text_count, pattern=pattern, sum=sum, vectorize=vectorize, ...)
    return(tmp)
  }
  if(vectorize){
    tmp <- mapply(gregexpr, pattern=pattern, text=string)
    names(tmp) <- NULL
    tmp <- vapply(tmp, function(tmp){sum(!is.na(tmp) & tmp!=-1)}, integer(1))
    tomp <-
      as.data.frame(
        do.call(
          rbind,
          mapply(c,i=seq_along(string), p=seq_along(pattern), SIMPLIFY = FALSE)
        )
      )
    tmp <- cbind(n=tmp, tomp)
    if(sum){
      return(sum(tmp$n))
    }else{
      return(tmp)
    }
  }else{
    tmp <- gregexpr(pattern, string, ...)
    tmp <- vapply(tmp, function(tmp){sum(!is.na(tmp) & tmp!=-1)}, integer(1))
    if(sum){
      return(sum(tmp))
    }else{
      return(tmp)
    }
  }
}


