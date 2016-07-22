#' function for make text lower case
#' @param x text to be processed
#' @export
text_to_lower <- function (x) {
  UseMethod("text_to_lower")
}

#' default method for text_tolower()
#' @rdname text_to_lower
#' @method text_to_lower default
#' @export
text_to_lower.default <- function(x){
  if(is.list(x)){
    return(
      lapply(x, tolower)
    )
  }else{
    return(tolower(x))
  }
}


#' function for make text lower case
#' @param x text to be processed
#' @export
text_to_upper <- function (x) {
  UseMethod("text_to_upper")
}

#' default method for text_to_upper()
#' @rdname text_to_upper
#' @method text_to_upper default
#' @export
text_to_upper.default <- function(x){
  if(is.list(x)){
    return(
      lapply(x, toupper)
    )
  }else{
    return(toupper(x))
  }
}


#' function for make text lower case
#' @param x text to be processed
#' @export
text_to_title_case <- function (x) {
  UseMethod("text_to_title_case")
}

#' default method for text_to_title_case.()
#' @rdname text_to_title_case
#' @method text_to_title_case default
#' @export
text_to_title_case.default <- function(x){
  if(is.list(x)){
    return(
      lapply(x, tools::toTitleCase)
    )
  }else{
    return(tools::toTitleCase(x))
  }
}




















