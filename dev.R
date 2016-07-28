string      <- c("1234567890", "abcd1d1999asdf","aafdsadsf")
pattern     <- "(\\d)\\d(\\d)"
replacement <- c("_1_","_2_")
group       <- TRUE
match       <- NULL
invert      <- FALSE




dev(string, pattern, "-", group = 1:2)

