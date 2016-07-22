

#' function for collapsing text vectors
#' @param x object to be collapsed
#' @param sep separator between text parts
#' @param ... additional parameter passed through to methods
#' @export
text_collapse <- function (x, ..., sep) {
  UseMethod("text_collapse")
}

#' default method for text_collapse()
#' @rdname text_collapse
#' @method text_collapse default
#' @export
text_collapse.default <- function(x, ..., sep=""){
  paste(x, ..., sep=sep, collapse = sep)
}

#' text_collapse() method for lists
#' @export
#' @rdname text_collapse
#' @method text_collapse list
text_collapse.list <- function(x, ..., sep=""){
      x   <- lapply(x, text_collapse, ..., sep=ifelse(length(sep)>1,sep[2], sep))
      x   <- unlist(x, recursive = FALSE)
      text_collapse(x, sep = sep )
}


#' text_collapse() method for data.frames
#' @export
#' @rdname text_collapse
#' @method text_collapse data.frame
text_collapse.data.frame <- function(x, ..., sep=c("", "\n")){
  if(is.data.frame(x)){
    x <- apply(x, 1, text_collapse, sep=sep[1])
    x <- unlist(x, recursive = FALSE)
  }
  if(length(sep)>1){
    sep <- sep[2]
  }
  text_collapse(x, sep=sep)
}

