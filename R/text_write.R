#' write text to file
#'
#' A generic function to write text to file (or a \link[base]{connection}) and
#'    accompanying methods that wrap \link[base]{writeLines} to do so. In contrast
#'    to vanilla writeLines() text_write() (1) is  a generic so methods, handling
#'    something else than character vectors, can be implemented (2) in contrast to
#'    writeLines()' default to transform to write text in the system locale
#'    text_write() will default to UTF-8 no matter the locale (3) furthermore this
#'    encoding can be changed to any encoding supported by \link[base]{iconv}
#'    (see also \link[base]{iconvlist})
#'
#' @param string text to be written
#' @param file file name or file path or an \link[base]{connection} object -
#'    passed through to writeLines()'s con argument
#' @param sep character to separate lines (i.e. vector elements) from each other
#' - passed through to writeLines()'s con argument
#' @param encoding encoding in which to write text to disk
#' @param ... further arguments that might be passed to methods
#' (not used at the moment)
#' @export
text_write <- function(string, file, sep="\n", encoding="UTF-8", ...){
  UseMethod("text_write")
}


#' text_write() default
#'
#' @rdname text_write
#' @method text_write default
#' @export
text_write.default <- function(string, file, sep="\n", encoding="UTF-8", ...){
  writeLines(
    text     = iconv(as.character(string),to=encoding),
    con      = file,
    sep      = sep,
    useBytes = TRUE
  )
}

