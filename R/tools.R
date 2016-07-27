#' helper function for text_replace_group
#' @param x text_replace_group result
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

#' helper function to standardize regexpr results
#' @param tmp regexpr or gregexpr result
#' @keywords internal
text_locate_cleanup <- function(tmp){
  tmp[tmp==-1] <- NA
  tmp_length <- attr(tmp, "match.length")
  tmp_length[tmp_length<0] <- NA
  tmp_end <- ifelse(tmp_length==0, NA, tmp+tmp_length-1)
  attributes(tmp) <- NULL
  data.frame(
    start  = tmp,
    end    = tmp_end,
    length = tmp_length
  )
}

#' helper for usage of regmatches
#' @param tmp result from regexec or gregexpr or regexpr
#' @keywords internal
cleanup_regex_results <-  function(tmp){
  for(i in seq_along(tmp) ){
    if( !tmp[[i]][1]==-1 ){
      match_length <- attr(tmp[[i]], "match.length")
      use_bytes    <- attr(tmp[[i]], "useBytes")
      tmp[[i]]     <- tmp[[i]][-1]
      attr(tmp[[i]], "match.length") <- match_length[-1]
      attr(tmp[[i]], "useBytes")     <- use_bytes
    }
  }
  tmp
}

#' a stringsAsFactors=FALSE data.frame
#' @param ... passed through to data.frame
#' @param stringsAsFactors set to false by default
#' @keywords internal
data.frame <- function(..., stringsAsFactors=FALSE){
  base::data.frame(..., stringsAsFactors = stringsAsFactors)
}

#' a stringsAsFactors=FALSE as.data.frame
#' @param ... passed through to data.frame
#' @param stringsAsFactors set to false by default
#' @keywords internal
as.data.frame <- function(..., stringsAsFactors=FALSE){
  base::as.data.frame(..., stringsAsFactors = stringsAsFactors)
}

#' function to sort df by variables
#' @param df data.frame to be sorted
#' @param ... column names to use for sorting
stringb_arrange <- function(df, ...){
  sorters    <- as.character(as.list(match.call()))
  if( length(sorters)>2 ){
    sorters    <- sorters[-c(1:2)]
    sorters    <- paste0("df['",sorters,"']", collapse = ", ")
    order_call <- paste0("order(",sorters,")")
    return(df[eval(parse(text=order_call)), ])
  }else{
    return(df)
  }
}

#' text function: wrapper for system.file() to access test files
#' @param x name of the file
#' @keywords internal
test_file <- function(x=NULL){
  if(is.numeric(x)){
    return(test_file(test_file()[(x-1) %% length(test_file()) +1 ]))
  }
  if(is.null(x)){
    return(list.files(system.file("testfiles", package = "stringb")))
  }else if(x==""){
    return(list.files(system.file("testfiles", package = "stringb")))
  }else{
    return(system.file(paste("testfiles", x, sep="/"), package = "stringb") )
  }
}


# #' have a look at environments
# #' @param env environment list objects
# #' @param filter filter for classes to be returned
# #' @export
# stringb_ls <- function(env = globalenv(), filter=FALSE){
#   names <- as.list(ls(env))
#   worker <- function(name){
#     data.frame(name, class=class(get(name, envir=env)))
#   }
#   tmp <- do.call(rbind, lapply(names, worker))
#   if(filter!=FALSE){
#     tmp[tmp$class %in% filter,]
#   }else{
#     return(tmp)
#   }
# }





















