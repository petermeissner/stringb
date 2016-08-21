#' generic for gregexpr wrappers to tokenize text
#' @param string text to be tokenized
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
   string,
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
#' @export
text_tokenize.default <-
  function(
    string,
    regex       = NULL,
    ignore.case = FALSE,
    fixed       = FALSE,
    perl        = FALSE,
    useBytes    = FALSE,
    non_token   = FALSE
  ){
    # recursion
    if(length(string)>1){
      lapply(
        string,
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
        tmp <- strsplit(string, regex)[[1]]
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
      tlength <- text_length(string)
      found_splitter <-
        gregexpr(
          pattern     = regex,
          text        = string,
          ignore.case = ignore.case,
          fixed       = fixed,
          useBytes    = useBytes
        )
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

      # dev : not used anymore? ...
      # char_token <-
      #  sort(unique(seq_len(tlength)[!(seq_len(tlength) %in% char_splitter)]))

      char_token_from     <- c(1,found_splitter_to+1)
      char_token_to       <- c(ifelse(found_splitter[[1]]==1, 1, found_splitter[[1]]-1),tlength)

      token <-
        data.frame(
          from  = char_token_from,
          to    = char_token_to
        )

      token_false_positive_iffer <-
        !(token$from %in% char_splitter | token$to %in% char_splitter)

      token <- subset(token, token_false_positive_iffer)

      # handling special cases
      if( tlength > 0  &  dim(token)[1] == 0  &  !all( found_splitter[[1]] > 0 ) ){
        token <- rbind(token, c(1, tlength))
        names(token) <- c("from", "to")
      }

      # filling with tokens
      if( ignore.case ){
        tmp <- regmatches(string, found_splitter, invert = TRUE)[[1]]
      }else{
        tmp <- unlist(strsplit(string, regex, fixed = fixed, perl = perl))
      }
      tmp <- subset(tmp, token_false_positive_iffer)

      token$token    <- tmp[seq_along(token$from)]
      token$is_token <- rep(TRUE, dim(token)[1])

      # adding non-tokens
      if( non_token == TRUE ){
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
            token    = regmatches(string, found_splitter)[[1]],
            is_token = rep(FALSE, length(found_splitter_to))
          )
        token <-
          rbind(token, non_token )
      }

      # return
      iffer <- is.na(token$token)
      if( sum(iffer) > 0 ){
        token[iffer, "token"] <- text_sub(string, token[iffer, "from"], token[iffer, "to"])
      }
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
#' @param string the text to be tokenized
#' @param non_token whether or not token as well as non tokens shall be returned.
#' @export
text_tokenize_words <- function(string, non_token = FALSE){
  UseMethod("text_tokenize_words")
}

#' text_tokenize default
#' @rdname text_tokenize_words
#' @method text_tokenize_words default
#' @export
text_tokenize_words.default <-
  function(
    string,
    non_token = FALSE
  ){
    res <- text_tokenize(string, "\\W+")
    if(non_token){
      tmp <- text_tokenize(string, "\\w+")
      tmp$is_token <- rep(FALSE, dim(tmp)[1])
      res <- rbind(res, tmp)
    }
    return(stringb_arrange(res, "from", "to"))
  }

#' generic to tokenize text into lines
#'
#'
#' @param string the text to be tokenized
#' @param non_token whether or not token as well as non tokens shall be returned.
#' @export
text_tokenize_lines <- function(string, non_token = FALSE){
  UseMethod("text_tokenize_lines")
}

#' text_tokenize default
#' @rdname text_tokenize_lines
#' @method text_tokenize_lines default
#' @export
text_tokenize_lines.default <-
  function(
    string,
    non_token = FALSE
  ){
    res <- text_tokenize(string, "\n")
    if(non_token){
      tmp <- text_tokenize(string, "[^\n]")
      tmp$is_token <- rep(FALSE, dim(tmp)[1])
      res <- rbind(res, tmp)
      res <- stringb_arrange(res, "from", "to")
    }
    return(res)
  }



#' generic to tokenize text into sentences
#'
#' @param string the text to be tokenized
#' @param non_token whether or not token as well as non tokens shall be returned.
#' @export
text_tokenize_sentences <- function(string, non_token=FALSE){
  UseMethod("text_tokenize_sentences")
}

#' text_tokenize default
#' @rdname text_tokenize_sentences
#' @method text_tokenize_sentences default
#' @export
text_tokenize_sentences.default <- function(string, non_token=FALSE){
    # find sentence boundaries
    sentence_boundaries_1       <- text_locate_all(string, "([\\.\\!\\?][ \n]+\\p{Lu})", perl=TRUE)[[1]]
    sentence_boundaries_1$start <- sentence_boundaries_1$start+1
    sentence_boundaries_1$end   <- sentence_boundaries_1$end-1
    sentence_boundaries_2       <- text_locate_all(string, "(\n ?\n+)", perl=TRUE)[[1]]

    sentence_boundaries  <- rbind(sentence_boundaries_1, sentence_boundaries_2)
    sentence_boundaries  <-
      subset(
        sentence_boundaries,
        !is.na(sentence_boundaries$start),
        -length
      )

    # invert to sentences
    sentences <-
      subset(
        invert_spans(sentence_boundaries, end=nchar(string)),
        TRUE,
        -length
      )
    names(sentences) <- c("from", "to")

    # get text
    sentences$token <- substring(string, sentences$from, sentences$to)
    sentences$is_token <- TRUE
    # non_token
    if( non_token ){
      names(sentence_boundaries) <- c("from", "to")
      sentence_boundaries$token  <- substring(string, sentence_boundaries$from, sentence_boundaries$to)
      sentence_boundaries$is_token <- FALSE
      sentences <- rbind(sentences, sentence_boundaries)
      sentences <- stringb_arrange(sentences, "from", "to")
    }
    # return
    return(sentences)
  }













