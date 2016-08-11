#' helper function to get start, end, length form pattern match
#' @param string text to be searched through
#' @param pattern regex to look for
#' @param ... further options passed through to \link[base]{regexpr}
text_locate_worker <- function(string, pattern, ...){
  tmp <- regexpr(pattern, string, ...)
  regmatches2(tmp)
}

#' function to get start, end, length form pattern match
#' @param string text to be searched through
#' @param pattern regex to look for
#' @param vectorize should function be used in vectorized mode, i.e. should a
#'    pattern with length larger than 1 be allowed and if so, should it be
#'    matched to lines (with recycling if needed) instead of using on element on
#'    all lines
#' @param ... further options passed through to \link[base]{regexpr}
#' @export
text_locate <- function(string, pattern, vectorize=FALSE, ...){
  UseMethod("text_locate")
}

#' text_locate default
#' @rdname text_locate
#' @method text_locate default
#' @export
text_locate.default <- function(string, pattern, vectorize=FALSE, ...){
  if(is.list(string)){
    res <-
      lapply(
        X         = string,
        FUN       = text_locate,
        pattern   = pattern,
        vectorize = vectorize,
        ...
      )
    return(res)
  }
  if( length(pattern>1) & vectorize ){
    res <-
      mapply(
      text_locate_worker,
      string   = string,
      pattern  = pattern,
      MoreArgs = ...,
      SIMPLIFY = FALSE
    )
  }else{
    res <- text_locate_worker(string, pattern, ...)
  }
  if(vectorize){
    for(i in seq_along(res)){
      res[[i]]$i <- i
      p <- i %% length(pattern)
      p[p==0] <- length(pattern)
      res[[i]]$p <-p
    }
    res <- do.call(rbind, res)
    rownames(res) <- NULL
  }
  return(res)
}


#' helper function to get start, end, length form pattern match
#' @param string text to be searched through
#' @param pattern regex to look for
#' @param ... further options passed through to \link[base]{regexpr}
text_locate_all_worker <- function(string, pattern, ...){
  tmp <- gregexpr(pattern, string, ...)
  lapply(tmp, regmatches2)
}

#' function to get start, end, length form pattern match for all matches
#' @param string text to search through
#' @param pattern regex to search for
#' @param vectorize should function be used in vectorized mode, i.e. should a
#'    pattern with length larger than 1 be allowed and if so, should it be
#'    matched to lines (with recycling if needed) instead of using on element on
#'    all lines
#' @param simplify either getting back a list of results or all list elements
#'    merged into a data.frame with columns identifying original line (i) and
#'    pattern (p) number
#' @param ... further arguments passed through to \link[base]{gregexpr}
#' @export
text_locate_all <- function(string, pattern, vectorize=FALSE, simplify=FALSE, ...){
  UseMethod("text_locate_all")
}

#' text_locate_all default
#' @rdname text_locate_all
#' @method text_locate_all default
#' @export
text_locate_all.default <- function(string, pattern, vectorize=FALSE, simplify=FALSE, ...){
  if(is.list(string)){
    return(lapply(string, text_locate_all, pattern, ..., vectorize=vectorize))
  }
  if( length(pattern>1) & vectorize==TRUE ){
    res <-
        mapply(
          text_locate_all_worker,
          string   = string,
          pattern  = pattern,
          MoreArgs = ...,
          SIMPLIFY = FALSE
        )
    res <- unlist(res, recursive = FALSE)
  }else{
    res <- text_locate_all_worker(string, pattern, ...)
  }
  if(simplify){
    for(i in seq_along(res)){
      res[[i]]$i <- i
      p <- i %% length(pattern)
      p[p==0] <- length(pattern)
      res[[i]]$p <-p
    }
    res <- do.call(rbind, res)
  }
  rownames(res) <- NULL
  return(res)
}


