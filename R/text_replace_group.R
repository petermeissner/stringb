#' text_replace_locates default
#' @param string text for which to replace parts
#' @param found result of an call to text_locate_group or text_locate
#'        - i.e. a list of data.frames
#'        with two columns named 'start' and 'end' that mark character spans
#'        to be replaced within the text elements
#' @param group vector of integers identifying thos regex groups to be replaced
#' @param replacement character vector of replacements of length 1 or
#'        length(group) to replace regex group matches (marked character spans
#'        provided by the found parameter)
#' @param invert should character spans provided by found or their counterparts
#'        be replaced
#' @export
text_replace_locates <- function(string, found, replacement, group, invert){
  UseMethod("text_replace_locates")
}


#' text_replace_locates default
#' @method text_replace_locates default
#' @rdname text_replace_locates
#' @export
text_replace_locates.default <- function(string, found, replacement, group, invert){
  start  <- found$start
  end    <- found$end
  if( any(is.na(start)) ){
    tmp <- string
  }else{
    end2   <- c(start-1, nchar(string[1]))
    start2 <- c(0,end+1)
    df     <- data.frame(start=c(start,start2), end=c(end, end2))
    df     <- df[order(df$start, df$end),]
    tmp    <- substring(string,df$start,df$end)
    if(invert){
      tmp[ seq_along(tmp) %% 2 == 1 ][group] <- replacement
    }else{
      tmp[ seq_along(tmp) %% 2 == 0 ][group] <- replacement
    }
    tmp <- text_collapse(tmp)
  }
  return(tmp)
}




#' function for replacing regex group matches
#' generic for getting regex group matches
#'
#' @param string text from which to extract character sequence
#' @param pattern regex to be searched for
#' @param ... further parameter passed through to \link[base]{regexec}
#' @param group vector of integers identifying thos regex groups to be replaced
#' @param replacement character vector of replacements of length 1 or
#'        length(group) to replace regex group matches (marked character spans
#'        provided by the found parameter)
#' @param invert should character spans provided by found or their counterparts
#'        be replaced
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

#' text_replace_group default
#' @rdname text_replace_group
#' @method text_replace_group default
#' @export
text_replace_group.default <-
  function(
    string,
    pattern,
    replacement,
    group=TRUE,
    invert=FALSE,
    ...
  ){
    found <- text_locate_group(string, pattern, ...)
    mapply(
      text_replace_locates,
      string,
      found,
      MoreArgs =
        list(
          replacement = replacement,
          group       = group,
          invert      = invert
        ),
      USE.NAMES = FALSE
    )
  }

