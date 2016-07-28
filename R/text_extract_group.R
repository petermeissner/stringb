#' generic for getting regex group matches
#'
#' @param string text from which to extract character sequence
#' @param pattern regex to be searched for
#' @param group integer vector to indicate those regex group matches to extract
#' @param invert whether or no matches or non-matches should be extracted
#' @param ... further parameter passed through to \link[base]{regexec}
#' @export
text_extract_group <- function(string, pattern, group, invert=FALSE, ...){
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
    res[,1] <- NULL
  }
  if( dim(res)[2]>0 ){
    names(res) <- text_c("group", seq_len(dim(res)[2]))
  }
  if( !is.null(group) ){
    return( get_groups(res, group) )
  }else{
    return(res)
  }
}

#' helper function for text_extract_group
#' @param x text_extract_group result
#' @param groups groups to extract
#' @keywords internal
get_groups <- function(x, group){
  groups <- text_c("group", group)
  tmp <- list()
  for(i in seq_along(groups) ){
    if( is.null(x[[groups[i]]]) ){
      tmp[[groups[i]]] <- rep(NA, dim(x)[1])
    }else{
      tmp[[groups[i]]] <- x[[groups[i]]]
    }
  }
  tmp <- as.data.frame(tmp)
  return(tmp)
}



#' generic for getting all regex group matches
#'
#' @param string text from which to extract character sequence
#' @param pattern regex to be searched for
#' @param invert whether or no matches or non-matches should be extracted
#' @param ... further parameter passed through to \link[base]{gregexpr}
#' @param group integer vector to indicate those regex group matches to extract
#' @export
text_extract_group_all <- function(string, pattern, group=NULL, invert=FALSE, ...){
  UseMethod("text_extract_group_all")
}

#' text default
#' @rdname text_extract_group_all
#' @method text_extract_group_all default
#' @export
text_extract_group_all.default <-
  function(string, pattern, group=NULL, invert=FALSE, ...){
  snippets <- text_extract_all(string, pattern)
  groups   <- lapply(snippets, regexec, pattern=pattern)
  res      <- mapply(regmatches, m=groups, x=snippets)
  worker   <- function(x){
    tmp <-
      as.data.frame(
        do.call(rbind, x)
      )[, -1]
    names(tmp) <- text_c("group", seq_len(dim(tmp)[2]))
    tmp
  }
  res <- lapply(res, worker)
  # group option
  if(!is.null(group)){
    res <- lapply(res, get_groups, group=group)
  }
  # match option
  if(!is.null(group)){
    res <- lapply(res, get_groups, group=group)
  }
  return(res)
}















