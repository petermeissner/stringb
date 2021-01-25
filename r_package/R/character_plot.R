#' function for plotting text
#' @export
#' @param x object of class rtext
#' @param y either NULL or a data.frame with columns "start", "end", "line"
#' @param col color for text
#' @param border border color for text
#' @param pattern_col color for text to be marked up via pattern or y option
#' @param pattern regular expression to be searched in text and marked up in plot
#' @param ... further parameters passed through to text_locate
plot.character <-
  function(
    x,
    y           = NULL,
    col    = "grey",
    border = "grey",
    pattern     = NULL,
    pattern_col = "#ED4C4C",
    ...
  ){
    string <- x
    # gen text data
    x <- nchar(x)
    y <- seq_along(x)
    maxy <- max(y)
    y    <- abs(y-maxy)+1
    # do empty plot
    graphics::plot(
      x    = x,
      y    = y,
      type = "n",
      ylab = "line",
      xlab = "char",
      xlim      = c(0, (ceiling(max(x)/10^nchar(max(x))*10))*(10^nchar(max(x))/10) ),
      ylim      = c(0, max(y)+1 ),
      axes=FALSE
    )
    # do text plot
    graphics::axis(1)
    graphics::axis(2,c(max(y),1),c(1,max(y)))
    graphics::box()
    graphics::rect(
      xleft=0,
      xright=x,
      ybottom=y-0.5,
      ytop=y+0.5,
      col = col,
      border = border,
      lty=0
    )
    # end or markup
    if( !is.null(pattern) ){
        found <- text_locate_all(string, pattern)
        for( i in seq_along(found) ){
          found[[i]]$line = i
        }
        found <- do.call(rbind, found)
        found <- found[!is.na(found$start),c("start", "end", "line")]
      graphics::rect(
        xleft   = found$start - 1,
        xright  = found$end,
        ybottom = length(string)+1 - found$line - 0.5,
        ytop    = length(string)+1 - found$line + 0.5,
        col     = pattern_col,
        border  = pattern_col#,
        #lty     = 0
      )
    }
  }
