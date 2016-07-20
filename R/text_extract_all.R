#' extract regex matches
#'
#' wrapper function around gregexec and regmatches
#'
#' @param x text from which to extract
#' @param pattern see \link{grep}
#' @param ignore.case see \link{grep}
#' @param perl see \link{grep}
#' @param fixed see \link{grep}
#' @param useBytes see \link{grep}
#' @export
text_extract_all <-
  function(
    x,
    pattern,
    ignore.case = FALSE,
    perl = FALSE,
    fixed = FALSE,
    useBytes = FALSE
  ){
    regmatches(
      x,
      gregexpr(
        pattern=pattern,
        text=x,
        ignore.case = ignore.case,
        perl = perl,
        fixed = fixed,
        useBytes = useBytes
      )
    )
  }
