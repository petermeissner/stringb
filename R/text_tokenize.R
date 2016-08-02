#' generic for gregexpr wrappers to tokenize text
#' @param x x object to be tokenized
#' @param regex regex expressing where to cut see (see \link[base]{gregexpr})
#' @param ignore.case whether or not reges should be case sensitive
#'    (see \link[base]{gregexpr})
#' @param fixed whether or not regex should be interpreted as is or as regular
#'    expression (see \link[base]{gregexpr})
#' @param perl whether or not Perl compatible regex should be used
#'    (see \link[base]{gregexpr})
#' @param useBytes byte-by-byte matching of regex or character-by-character
#'    (see \link[base]{gregexpr})
#' @param non_token should information for non-token, i.e. those patterns by
#'    which the text was splitted, be returned as well
#' @export
text_tokenize <- function (
   x,
   regex       = NULL,
   ignore.case = FALSE,
   fixed       = FALSE,
   perl        = FALSE,
   useBytes    = FALSE,
   non_token   = FALSE
 ){
  UseMethod("text_tokenize")
}

#' default method for text_tokenize generic
#' @rdname text_tokenize
#' @method text_tokenize default
#' @return data.frame,
#'    token: string of the token;
#'    from: position in text at which token starts;
#'    to: position in text at which the token ends
#'    length: length of the token;
#'    type: type of the token, either its matched by regular expression used
#'    for tokenization or not matched
#' @export
text_tokenize.default <-
  function(
    x,
    regex       = NULL,
    ignore.case = FALSE,
    fixed       = FALSE,
    perl        = FALSE,
    useBytes    = FALSE,
    non_token   = FALSE
  ){
    # recursion
    if(length(x)>1){
      lapply(
        x,
        text_tokenize,
        regex       = regex,
        ignore.case = ignore.case,
        fixed       = fixed,
        perl        = perl,
        useBytes    = useBytes,
        non_token   = non_token
      )
    }else{
      # special cases
      if( any(grepl(regex, "")==TRUE) ){
        tmp <- strsplit(x, regex)[[1]]
        token <- data.frame(
          from     = seq_along(tmp),
          to       = seq_along(tmp),
          token    = tmp,
          is_token = rep(TRUE, length(tmp))
        )
        return(stringb_arrange(token, "from", "to"))
      }
      if( is.null(regex) ){
        regex <- ".*"
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
        subset(token, !(token$from %in% char_splitter | token$to %in% char_splitter))

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
      return(stringb_arrange(token, "from", "to"))
    }
  }

#' generic to tokenize text into words
#'
#' A wrapper to text_tokenize that tokenizes text into words.
#' Since using text_tokenize()'s option non_token might slow things
#' down considerably this one purpose wrapper is a little more clever
#' than the general implementation and hence much faster.
#'
#' @param x the text to be tokenized
#' @param non_token whether or not token as well as non tokens shall be returned.
#' @export
text_tokenize_words <- function(string, non_token = FALSE){
  UseMethod("text_tokenize_words")
}

#' text_tokenize default
#' @rdname text_tokenize_words
#' @method text_tokenize default
#' @export
text_tokenize_words.default <-
  function(
    x,
    non_token = FALSE
  ){
    res <- text_tokenize(x, "\\W+")
    if(non_token){
      tmp <- text_tokenize(x, "\\w+")
      tmp$is_token <- rep(FALSE, dim(tmp)[1])
      res <- rbind(res, tmp)
    }
    return(stringb_arrange(res, "from", "to"))
  }

