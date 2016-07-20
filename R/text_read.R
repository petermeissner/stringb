#' read in text
#'
#' A wrapper to readLines() to make things more ordered and convenient. In
#' comparison to the wrapped up readLines() function text_read() does some
#' things differently: (1) If no encoding is given, it will always assume files
#' are stored in UTF-8 instead of the system locale. (2) it will always converts
#' text to UTF-8 instead of transforming it to the system locale. (3) in
#' addition to loading, it offers to tokenize the text using a regular expression
#' or NULL for no tokenization at all.
#'
#' @param file name or path to the file to be read in or a \link[base]{connection} object (see \link[base]{readLines})
#' @param tokenize either
#'    NULL so that no splitting is done;
#'    a regular expression to use to split text into parts;
#'    or a function that does the splitting (or whatever other transformation)
#' @param encoding character encoding of file passed throught to \link[base]{readLines}
#' @param ... further arguments passed through to \link[base]{readLines} like:
#'   n, ok, warn, skipNul
#' @export

text_read <- function(file, tokenize="\n", encoding="UTF-8", ...)
{
  tmp <- readLines(file, ...)
  # transform to UTF-8 encoding
  tmp <- iconv(tmp, encoding, "UTF-8")
  # all within one vector element
  if( is.null(tokenize) ){
    return(paste0(tmp, collapse = "\n"))
  }
  # tokenized by function
  if(is.function(tokenize)){
    return( unlist(tokenize(paste0(tmp, collapse = "\n"))) )
  }
  # vector elements should correspond to lines
  if(tokenize == "\n"){
    return(tmp)
  }
  # tokenized by other pattern
  if(is.character(tokenize)){
    return(unlist(strsplit(paste0(tmp, collapse = "\n"), tokenize)))
  }
}

