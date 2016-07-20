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
#' @export
#' @param x name of the file
stringb_tf <- function(x=NULL){
  if(is.numeric(x)){
    return(stringb_tf(stringb_tf()[(x-1) %% length(stringb_tf()) +1 ]))
  }
  if(is.null(x)){
    return(list.files(system.file("testfiles", package = "stringb")))
  }else if(x==""){
    return(list.files(system.file("testfiles", package = "stringb")))
  }else{
    return(system.file(paste("testfiles", x, sep="/"), package = "stringb") )
  }
}


#' have a look at environments
#' @param env environment list objects
#' @param filter filter for classes to be returned
#' @export
stringb_ls <- function(env = globalenv(), filter=FALSE){
  names <- as.list(ls(env))
  worker <- function(name){
    data.frame(name, class=class(get(name, envir=env)))
  }
  tmp <- do.call(rbind, lapply(names, worker))
  if(filter!=FALSE){
    tmp[tmp$class %in% filter,]
  }else{
    return(tmp)
  }
}





















