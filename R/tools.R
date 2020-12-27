#' function to invert spans to those numbers not covered
#' @param from vector of span starts
#' @param to vector of span ends
#' @param start minimum
#' @param end maximum value
invert_spans <- function(from, to=NULL, start=1, end=Inf){
  if( is.data.frame(from) & is.null(to) ){
    to   <- from$end
    from <- from$start
  }
  if(is.infinite(end)){
    tmp <- (start:(max(to)+1))[!(start:(max(to)+1) %in% sequenize(from, to))]
  }else{
    tmp <- (start:end)[!(start:end %in% sequenize(from, to))]
  }
  tmp <- de_sequenize(tmp)
  if(is.infinite(end)){
    tmp$end[length(tmp$end)] <- Inf
  }
  tmp$length <- tmp$end - tmp$start +1
  tmp$length[is.na(tmp$length)] <- Inf
  return(tmp)
}

#' helper function that turns cut points into spans
#' @param cuts where after to cut into pieces
#' @param end where does it all end
#' @keywords internal
cuts_to_spans <- function(cuts, start=1, end=Inf){
  cuts <- sort(cuts)
  # doing duty to do
  from  <- c(1, cuts + 1)
  to    <- c(cuts, end)
  tmp   <- data.frame(from, to)
  # consistency checks
  tmp <-
    subset(
      tmp,
      !(
        to > end |
          from > end |
          duplicated(tmp) |
          to < start |
          from < start
      )
    )
  return(tmp)
}


#' helper function to spans into sequences
#' @param start first number of sequence
#' @param end last number of sequence
#' @param simplify discard order, duplicaes etc?
#' @keywords internal
sequenize <- function(start, end=NULL, simplify=TRUE){
  if( is.null(end) ){
    if(is.matrix(start)){
      end   <- start[,2]
      start <- start[,1]
    }else{
      end   <- start[[2]]
      start <- start[[1]]
    }
  }
  tmp <- mapply(seq, start, end)
  if(simplify){
    tmp <- sort(unique(unlist(tmp)))
  }
  return(tmp)
}



#' helper function to transforms sequences into spans
#' @param x a bunch of numbers to urn into sequences
#' @keywords internal
de_sequenize <- function(x){
  x <- sort(unique(unlist(x)))
  xmin  <- min(x)
  xlead <- x[-1]
  xdiff <- c(xlead, NA) - x
  iffer <- is.na(xdiff) | xdiff > 1
  end   <- x[iffer]
  start <- c( xmin, xlead[iffer[seq_len(length(iffer)-1)]] )
  return(data.frame(start, end))
}



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
regmatches2 <- function(tmp, group=TRUE){
  if(is.list(tmp)){
    return(lapply(tmp, regmatches2, group=group))
  }
  # make data frame of match positions
  start            <- tmp
  start[start==-1] <- NA
  length               <- attr(start, "match.length")
  length[ length < 0]  <- NA
  end <- ifelse( length == 0, NA, start + length-1 )
  attributes(start) <- NULL
  df <- data.frame(start, end, length)
  # return
  return(df[group,])
}

#' helper for usage of regmatches
#' @param tmp result from regexec or gregexpr or regexpr
#' @keywords internal
drop_non_group_matches <-  function(tmp, group=TRUE){
  for(i in seq_along(tmp) ){
    if( !tmp[[i]][1]==-1 ){
      match_length <- attr(tmp[[i]], "match.length")
      use_bytes    <- attr(tmp[[i]], "useBytes")
      tmp[[i]]     <- tmp[[i]][-1][group]
      attr(tmp[[i]], "match.length") <- match_length[-1][group]
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
    sorters     <- sorters[-c(1:2)]
    sort_list   <- unname(as.list(df[, sorters, drop=FALSE]))
    order_index <- do.call(order, sort_list)
    return(df[order_index, , drop=FALSE])
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


















