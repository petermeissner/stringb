#' function for replacing regex group matches
#' generic for getting regex group matches
#'
#' @param string text from which to extract character sequence
#' @param pattern regex to be searched for
#' @param ... further parameter passed through to \link[base]{regexec}
#' @export
text_replace_group <-
  function(
    string,
    pattern,
    replacement,
    group=seq_along(replacement),
    invert=FALSE,
    ...
){
  UseMethod("text_replace_group")
}

#' text default
#' @rdname text_replace_group
#' @method text_replace_group default
#' @export
text_replace_group.default <-
  function(
    string,
    pattern,
    replacement,
    group=seq_along(replacement),
    invert=FALSE,
    ...
){
    tmp   <- regexpr(pattern = pattern, text=string)
    tmp   <- cleanup_regex_results(tmp)
    tmp   <- regmatches(string, tmp)
    found <- lapply(tmp, length)!=0
    for(i in seq_along(tmp)[found] ){
      tmp[[i]][group] <- replacement
    }
    rpl   <- lapply(tmp, text_collapse)
    text_replace(string, pattern, replacement = rpl, recycle = TRUE)
}


#' generic for getting all regex group matches
#'
#' @param string text from which to extract character sequence
#' @param pattern regex to be searched for
#' @param ... further parameter passed through to \link[base]{gregexpr}
#' @export
text_replace_group_all <- function(string, pattern, invert=FALSE, ...){
  UseMethod("text_replace_group_all")
}

#' text default
#' @rdname text_replace_group_all
#' @method text_replace_group_all default
#' @export
text_replace_group_all.default <-
  function(string, pattern, group=NULL, match=NULL, invert=FALSE, ...){
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
  }















