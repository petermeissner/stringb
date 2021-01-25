#' extract regex matches
#'
#' wrapper function around regexec and regmatches
#'
#' @param x text from which to extract
#' @param pattern see \link{grep}
#' @param ignore.case see \link{grep}
#' @param perl see \link{grep}
#' @param fixed see \link{grep}
#' @param useBytes see \link{grep}
#' @param invert if TRUE non-regex-matches are extracted instead
#' @export
text_extract <-
  function(
    x,
    pattern,
    ignore.case = FALSE,
    perl        = FALSE,
    fixed       = FALSE,
    useBytes    = FALSE,
    invert      = FALSE
  ){
    regmatches(
      x,
       regexpr(
         pattern     = pattern,
         text        = x,
         ignore.case = ignore.case,
         perl        = perl,
         fixed       = fixed,
         useBytes    = useBytes
       ),
      invert = invert
    )
  }





