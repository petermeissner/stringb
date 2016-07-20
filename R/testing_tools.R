#' text function: wrapper for system.file() to access test files
#' @param x name of the file
dp_tf <- function(x=NULL){
  if(is.numeric(x)){
    return(dp_tf(dp_tf()[(x-1) %% length(dp_tf()) +1 ]))
  }
  if(is.null(x)){
    return(list.files(system.file("testfiles", package = "diffrprojects")))
  }else if(x==""){
    return(list.files(system.file("testfiles", package = "diffrprojects")))
  }else{
    return(system.file(paste("testfiles", x, sep="/"), package = "diffrprojects") )
  }
}


#' have a look at environments
#' @param env environment list objects
#' @param filter filter for classes to be returned
dp_ls <- function(env = globalenv(), filter=FALSE){
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
