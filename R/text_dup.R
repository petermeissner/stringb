#' generic repeating text
#' @param string text to be repeated
#' @param times how many times shal string be repeated
#' @param vectorize should function be used in vectorized mode, i.e. should a
#'    pattern with length larger than 1 be allowed and if so, should it be
#'    matched to lines (with recycling if needed) instead of using on element on
#'    all lines
#' @param ... further arguments passed through
#' @export
text_rep <- function(string, times, vectorize=FALSE, ...){
  UseMethod("text_rep")
}

#' @export
#' @rdname text_rep
text_dup <- function(string, times, vectorize=FALSE, ...){
  UseMethod("text_rep")
}



#' text_rep defaul method
#' @rdname text_rep
#' @method text_rep default
#' @export
text_rep.default <- function(string, times, vectorize=FALSE, ...){
  # list handling
  if(is.list(string)){
    tmp  <- lapply(string, text_rep, times=times, vectorize=vectorize, ...)
    return(tmp)
  }
  # sanatize input
  times[times<0] <- 0
  # doing duty-to-do
  if(vectorize){
    # text
    tmp           <- mapply(text_rep, string, times)
    Encoding(tmp) <- "UTF-8"
    names(tmp)    <- NULL
    # data
    tomp <-
      as.data.frame(
        do.call(
          rbind,
          mapply(c,i=seq_along(string), p=seq_along(times), SIMPLIFY = FALSE)
        )
      )
    # return
    tmp <- data.frame(t=tmp, i=tomp$i, p=tomp$p)
    rownames(tmp) <- NULL
    return(tmp)
  }else{
    tmp <-
      vapply(
        X   = string,
        FUN = strrep,
        FUN.VALUE = "",
        times = times
      )
    Encoding(tmp) <- "UTF-8"
    return(tmp)
  }
}










