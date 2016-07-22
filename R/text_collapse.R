

#' function for collapsing text vectors
#' @param x object to be collapsed
#' @param coll separator between collapsed text parts
#' @param ... additional parameter passed through to methods
#' @export
text_collapse <- function (x, coll="") {
  UseMethod("text_collapse")
}

#' default method for text_collapse()
#' @rdname text_collapse
#' @method text_collapse default
#' @export
text_collapse.default <- function(x, coll=""){
    paste0(unlist(x), collapse = coll)
}

#' text_collapse() mehtod for list
#' @rdname text_collapse
#' @method text_collapse list
#' @export
text_collapse.list <- function(x, coll=""){
  text_collapse(
    unlist(lapply(x, text_collapse, coll=coll)),
    coll)
}



#' text_collapse() method for data.frames
#' @export
#' @rdname text_collapse
#' @method text_collapse data.frame
text_collapse.data.frame <- function(x, coll=""){
    x <- apply(x, 1, text_collapse, coll=coll[1])
    x <- unlist(x, recursive = FALSE)
  if(length(coll)>1){
    coll <- coll[2]
  }
  text_collapse(x, coll=coll)
}


#' text_collapse() method for matrix
#' @export
#' @rdname text_collapse
#' @method text_collapse matrix
text_collapse.matrix <- function(x, coll=""){
  text_collapse(as.data.frame(x), coll)
}

