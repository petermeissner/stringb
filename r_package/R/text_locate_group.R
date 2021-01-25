#' generic for getting positions regex groups
#' @inheritParams text_locate
#' @param group integer vector specifying groups to return
#' @export
text_locate_group <- function(string, pattern, group, ... ){
  UseMethod("text_locate_group")
}

#' text_locate_group default
#' @rdname text_locate_group
#' @method text_locate_group default
#' @export
text_locate_group.default <- function(string, pattern, group, ... ){
  positions    <- regexec(pattern = pattern, text=string, ...)
  positions    <- drop_non_group_matches(positions, group)
  regmatches2(positions)
}
