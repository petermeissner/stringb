#' generic for getting regex group matches
#'
#' @param string text from which to extract character sequence
#' @param pattern regex to be searched for
#' @param ... further parameter passed through to \link[base]{regexpr}
#' @seealso \link{text_extract_group}
#' @export
text_match <- function(string, pattern, invert=FALSE, ...){
  UseMethod("text_extract_group")
}

#' generic for getting regex group matches
#'
#' @param string text from which to extract character sequence
#' @param pattern regex to be searched for
#' @param ... further parameter passed through to \link[base]{regexec}
#' @export
text_extract_group <- function(string, pattern, invert=FALSE, ...){
  UseMethod("text_extract_group")
}


#' text default
#' @rdname text_extract_group
#' @method text_extract_group default
#' @export
text_extract_group.default <- function(string, pattern, group=NULL, invert=FALSE, ...){
    tmp   <- regexec(pattern = pattern, text=string)
    found <- vapply(tmp, `[`, 1, 1)!=-1
    if(invert){
      for(i in seq_along(tmp) ){
        match_length <- attr(tmp[[i]], "match.length")
        use_bytes    <- attr(tmp[[i]], "useBytes")
        tmp[[i]]     <- tmp[[i]][-1]
        attr(tmp[[i]], "match.length") <- match_length[-1]
        attr(tmp[[i]], "useBytes")     <- use_bytes
      }
      res <- regmatches(string, tmp, invert = invert)
      res[!found] <- NA
      res <- as.data.frame( do.call(rbind, res) )
    }else{
      res <- regmatches(string, tmp, invert = invert)
      res[!found] <- NA
      res <- as.data.frame( do.call(rbind, res) )
      res <- res[,-1]
    }
    names(res) <- text_c("group", seq_len(dim(res)[2]))
    return(res)
}






#' generic for getting all regex group matches
#'
#' @param string text from which to extract character sequence
#' @param pattern regex to be searched for
#' @param ... further parameter passed through to \link[base]{gregexpr}
#' @export
text_extract_group_all <- function(string, pattern, invert=FALSE, ...){
  UseMethod("text_extract_group_all")
}


#' text default
#' @rdname text_extract_group_all
#' @method text_extract_group_all default
#' @export
text_extract_group_all.default <- function(string, pattern, group=NULL, match=NULL, invert=FALSE, ...){
  tmp         <- text_extract_all(string, pattern)
  lapply(tmp, regexec, text=string, pattern=pattern)
  found       <- vapply(tmp, `[`, 1, 1)!=-1
  res         <- regmatches(string, tmp, invert = invert)
  res[!found] <- NA
  res <- as.data.frame( do.call(rbind, res) )
  names(res) <- text_c("group", seq_len(dim(res)[2]))
  return(res)
}















