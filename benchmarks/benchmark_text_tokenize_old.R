
text_tokenize_old <- function(x, regex=NULL, ignore.case=FALSE, fixed=FALSE, useBytes=FALSE, group=c("words", "lines", "paragraphs")){
  tlength <- text_length(x)

  found        <- gregexpr(regex, x, ignore.case, fixed, useBytes)
  found_from   <- found[[1]]
  found_length <- attributes(found[[1]])$match.length
  found_to     <- found_length+found_from-1

  token <-
    do.call(
      rbind,
      mapply(
        function(x, from, to){ data.frame(from, to, token = substring(x, from, to)) },
        from=found_from,
        to=found_to,
        MoreArgs = list(x      = x),
        SIMPLIFY = FALSE
      )
    )
  token$is_token <- TRUE

  non_token <-
    data.frame(
      from=c(1,token$to+1),
      to=c(token$from-1, tlength)
    )
  non_token <- non_token[non_token$from<=non_token$to,]
  non_token$token <- mapply(substring, first=non_token$from, last=non_token$to, MoreArgs = list(text=x))
  non_token$is_token=FALSE

  res <- rbind(token, non_token)
  res <- res[order(res$from),]
  res
}



#### ====================================================================================

text_tokenize_2 <- function(x, regex=NULL, ignore.case=FALSE, fixed=FALSE, useBytes=FALSE, group=c("words", "lines", "paragraphs")){
  tlength <- text_length(x)

  found        <- gregexpr(regex, x, ignore.case, fixed, useBytes)
  found_from   <- found[[1]]
  found_length <- attributes(found[[1]])$match.length
  found_to     <- found_length+found_from-1


  tmp <- mapply(
    function(x, from, to){ data.frame(from, to, token = substring(x, from, to)) },
    x,
    from=found_from,
    to=found_to,
    SIMPLIFY = FALSE
  )

  token <- data.table::rbindlist(tmp)

  token$is_token <- TRUE
  res <- token


  # non_token <-
  #   data.frame(
  #     from=c(1,token$to+1),
  #     to=c(token$from-1, tlength)
  #   )
  # non_token <- non_token[non_token$from<=non_token$to,]
  # non_token$token <- mapply(substring, first=non_token$from, last=non_token$to, MoreArgs = list(text=x))
  # non_token$is_token=FALSE
  #
  # res <- rbind(token, non_token)
  # res <- res[order(res$from),]
  res
}


#### ====================================================================================

text_tokenize_3 <- function(x, regex=NULL, ignore.case=FALSE, fixed=FALSE, useBytes=FALSE, group=c("words", "lines", "paragraphs")){
  tlength <- text_length(x)

  found        <- gregexpr(regex, x, ignore.case, fixed, useBytes)
  found_from   <- found[[1]]
  found_length <- attributes(found[[1]])$match.length
  found_to     <- found_length+found_from-1


  tmp <- mapply(
    function(x, from, to){ data.frame(from, to, token = substring(x, from, to)) },
    x,
    from=found_from,
    to=found_to,
    SIMPLIFY = FALSE
  )
}




#### ====================================================================================

text_tokenize_4 <- function(x, regex=NULL, ignore.case=FALSE, fixed=FALSE, useBytes=FALSE, group=c("words", "lines", "paragraphs")){
  tlength <- text_length(x)

  found        <- gregexpr(regex, x, ignore.case, fixed, useBytes)
  found_from   <- found[[1]]
  found_length <- attributes(found[[1]])$match.length
  found_to     <- found_length+found_from-1

  data.frame(
    from  = found_from,
    to    = found_to,
    token = substring(x, found_from, found_to)
  )
}




#### ====================================================================================

text_tokenize_4find <- function(x, regex=NULL, ignore.case=FALSE, fixed=FALSE, useBytes=FALSE, group=c("words", "lines", "paragraphs")){
  tlength <- text_length(x)

  found        <- gregexpr(regex, x, ignore.case, fixed, useBytes)
  found_from   <- found[[1]]
  found_length <- attributes(found[[1]])$match.length
  found_to     <- found_length+found_from-1

  data.frame(
    from  = found_from,
    to    = found_to,
    token = "elkmilk is fresh" #substring(x, found_from, found_to)
  )
}


#### ====================================================================================

text_tokenize_4subs <- function(x, regex=NULL, ignore.case=FALSE, fixed=FALSE, useBytes=FALSE, group=c("words", "lines", "paragraphs")){
  tlength <- text_length(x)

  found        <- gregexpr(regex, x, ignore.case, fixed, useBytes)
  found_from   <- found[[1]]
  found_length <- attributes(found[[1]])$match.length
  found_to     <- found_length+found_from-1

  data.frame(
    from  = found_from,
    to    = found_to,
    token = substring(x, found_from, found_to)
  )
}
