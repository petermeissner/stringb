#### ====================================================================================

library(stringb)
library(ggplot2)
library(profvis)
library(microbenchmark)

#### ====================================================================================



source("benchmarks/benchmark_text_tokenize_old.R")


#### ====================================================================================

x1 <- "Daniel Defoe: Robinson Crusoe\n\n* Quelle"
x2 <- "Daniel Defoe: Robinson Crusoe\n\n* Quelle: "
x3 <- " Daniel Defoe: Robinson Crusoe\n\n* Quelle: "
xfull <- text_read(stringb_tf("rc_1.txt"))

x <- x3
regex <- "\\W+"
ignore.case=FALSE
fixed=FALSE
useBytes=FALSE
group=c("words", "lines", "paragraphs")

x     <- "   "
regex <- " "

text_tokenize_5 <-
  function(
    x,
    regex       = NULL,
    ignore.case = FALSE,
    fixed       = FALSE,
    useBytes    = FALSE,
    non_token   = TRUE
  ){

    if( any(grepl(regex, "")==TRUE) ){
      tmp <- strsplit(x, regex)[[1]]
      token <- data.frame(
        from     = seq_along(tmp),
        to       = seq_along(tmp),
        token    = tmp,
        is_token = rep(TRUE, length(tmp))
      )
      return(token)
    }

    # finding characters spans where to split
    tlength <- text_length(x)
    found_splitter        <- gregexpr(regex, x, ignore.case, fixed, useBytes)
    found_splitter_from   <- found_splitter[[1]]
    found_splitter_length <- attributes(found_splitter[[1]])$match.length
    found_splitter_to     <- found_splitter_length+found_splitter_from-1

    # infering tokens
    char_splitter <-
      unique(
        unlist(
          mapply(seq, found_splitter_from, found_splitter_to, SIMPLIFY = FALSE)
        )
      )

    char_token <-
      sort(unique(seq_len(tlength)[!(seq_len(tlength) %in% char_splitter)]))

    char_token_from     <- c(1,found_splitter_to+1)
    char_token_to       <- c(ifelse(found_splitter[[1]]==1, 1, found_splitter[[1]]-1),tlength)

    token <-
      data.frame(
        from  = char_token_from,
        to    = char_token_to
      )

    token <-
      subset(token, !(from %in% char_splitter | to %in% char_splitter))

    # handling special cases
    if( tlength>0 & dim(token)[1]==0 & !all(found_splitter[[1]]>0) ){
      token <- rbind(token, c(1, tlength))
      names(token) <- c("from", "to")
    }

    # filling with tokens
    tmp <- unlist(strsplit(x, regex))
    tmp <- tmp[tmp!=""]

    token$token    <- tmp[seq_along(token$from)]
    token$is_token <- rep(TRUE, dim(token)[1])

    # adding non-tokens
    if(non_token==TRUE){
      # handling special cases
      if( any(found_splitter_to<0) | any(found_splitter_from<0) ){
        found_splitter_to   <- integer(0)
        found_splitter_from <- integer(0)
      }
      # adding to token
      non_token <-
        data.frame(
          from     = found_splitter_from,
          to       = found_splitter_to,
          token    = regmatches(x, found_splitter)[[1]],
          is_token = rep(FALSE, length(found_splitter_to))
        )
      token <-
        rbind(token, non_token )
    }

    # return
    return(token)
  }



#### ====================================================================================

x1 <- "Daniel Defoe: Robinson Crusoe\n\n* Quelle"
x2 <- "Daniel Defoe: Robinson Crusoe\n\n* Quelle: "
x3 <- " Daniel Defoe: Robinson Crusoe\n\n* Quelle: "
xfull <- text_read(stringb_tf("rc_1.txt"))

x <- xfull
regex <- "\\W+"
ignore.case=FALSE
fixed=FALSE
useBytes=FALSE
group=c("words", "lines", "paragraphs")


text_tokenize_6 <-
  function(
    x,
    regex       = NULL,
    ignore.case = FALSE,
    fixed       = FALSE,
    useBytes    = FALSE,
    non_token   = FALSE
  ){

    if( any(grepl(regex, "")==TRUE) ){
      tmp <- strsplit(x, regex)[[1]]
      token <- data.frame(
        from     = seq_along(tmp),
        to       = seq_along(tmp),
        token    = tmp,
        is_token = rep(TRUE, length(tmp))
      )
      return(token)
    }

    # finding characters spans where to split
    tlength <- text_length(x)
    found_splitter        <- gregexpr(regex, x, ignore.case, fixed, useBytes)
    found_splitter_from   <- found_splitter[[1]]
    found_splitter_length <- attributes(found_splitter[[1]])$match.length
    found_splitter_to     <- found_splitter_length+found_splitter_from-1

    # infering tokens
    char_splitter <-
      unique(
        unlist(
          mapply(seq, found_splitter_from, found_splitter_to, SIMPLIFY = FALSE)
        )
      )

    char_token <-
      sort(unique(seq_len(tlength)[!(seq_len(tlength) %in% char_splitter)]))

    char_token_from     <- c(1,found_splitter_to+1)
    char_token_to       <- c(ifelse(found_splitter[[1]]==1, 1, found_splitter[[1]]-1),tlength)

    token <-
      data.frame(
        from  = char_token_from,
        to    = char_token_to
      )

    token <-
      subset(token, !(from %in% char_splitter | to %in% char_splitter))

    # handling special cases
    if( tlength>0 & dim(token)[1]==0 & !all(found_splitter[[1]]>0) ){
      token <- rbind(token, c(1, tlength))
      names(token) <- c("from", "to")
    }

    # filling with tokens
    tmp <- unlist(strsplit(x, regex))
    tmp <- tmp[tmp!=""]

    token$token    <- tmp[seq_along(token$from)]
    token$is_token <- rep(TRUE, dim(token)[1])

    # adding non-tokens
    if(non_token==TRUE){
      # handling special cases
      if( any(found_splitter_to<0) | any(found_splitter_from<0) ){
        found_splitter_to   <- integer(0)
        found_splitter_from <- integer(0)
      }
      # adding to token
      non_token <-
        data.frame(
          from     = found_splitter_from,
          to       = found_splitter_to,
          token    = regmatches(x, found_splitter)[[1]],
          is_token = rep(FALSE, length(found_splitter_to))
        )
      token <-
        rbind(token, non_token )
    }

    # return
    return(token)
  }





profvis(
  text_tokenize(substring(xfull,1, 10000), "\\W+")
)

profvis(
  text_tokenize(substring(xfull,1, 100000), "\\W+")
)




#### ====================================================================================
#### TESTING ####


regex <- "\\W+"
ignore.case=FALSE
fixed=FALSE
useBytes=FALSE
group=c("words", "lines", "paragraphs")

xfull <- text_read(stringb_tf("rc_1.txt"))
RES   <- list()
stime <- Sys.time()

for(i in round((1:20)^4.61) ){
  x  <- substring(xfull, 1, i)
  i  <- text_length(x)
  regex <- "\\W+"
  ignore.case=FALSE
  fixed=FALSE
  useBytes=FALSE
  group=c("words", "lines", "paragraphs")

  bm_res <-
    microbenchmark::microbenchmark(
      #text_tokenize_old(x, regex),
      #text_tokenize_2(x, regex),
      #text_tokenize_3(x, regex),
      #text_tokenize_4(x, regex),
      #text_tokenize_4find(x, regex),
      #text_tokenize_4subs(x, regex),
      #text_tokenize_5(x, regex),
      text_tokenize(x, regex),
      text_tokenize_words(x, non_token = TRUE),
      text_tokenize_words(x, non_token = FALSE),
      unit="s", times = 1
    )
  tmp          <- aggregate(list(seconds=bm_res$time), by=list("fun"=bm_res[,1]), function(x){round(mean(x)/1000000000,4)})
  tmp$seconds2 <- as.numeric(Sys.time()) - as.numeric(stime)
  tmp$N        <- i
  RES          <- rbind(RES, tmp)

  cat(i, " ", as.numeric(Sys.time()) - as.numeric(stime), "\n")
}



ggplot(RES, aes(x=N, y=seconds, colour=fun)) +
  geom_line( ) +
  geom_hline(yintercept=0:3) +
  geom_vline(xintercept=c(0,text_length(xfull)))

RES


# load("bm_res_1.Rdata")

















