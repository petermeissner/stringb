% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/text_dup.R
\name{text_rep}
\alias{text_rep}
\alias{text_dup}
\alias{text_rep.default}
\title{generic repeating text}
\usage{
text_rep(string, times, vectorize = FALSE, ...)

text_dup(string, times, vectorize = FALSE, ...)

\method{text_rep}{default}(string, times, vectorize = FALSE, ...)
}
\arguments{
\item{string}{text to be repeated}

\item{times}{how many times shal string be repeated}

\item{vectorize}{should function be used in vectorized mode, i.e. should a
pattern with length larger than 1 be allowed and if so, should it be
matched to lines (with recycling if needed) instead of using on element on
all lines}

\item{...}{further arguments passed through}
}
\description{
generic repeating text

text_rep defaul method
}
