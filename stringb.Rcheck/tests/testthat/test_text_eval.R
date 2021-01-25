#### text_eval ===============================================================
context("text_eval")

test_that("text_eval works works", {
  expect_true({
    text_eval("aaaaaaaaaaaaaaaaaaaaaaaaa <- 74")
    "aaaaaaaaaaaaaaaaaaaaaaaaa" %in% ls()
  })
  expect_true({
    x <- 1
    ENV <- new.env()
    text_eval("y=x", envir = ENV)
    ENV$y==1
  })
  expect_true({
    x <- 1
    ENV <- new.env(parent=baseenv())
    text_eval("y = 2", envir = ENV, enclos=emptyenv())
    ENV$y==2
  })
  expect_error({
    x <- 1
    ENV <- new.env(parent=baseenv())
    text_eval("y = x", envir = ENV, enclos=emptyenv())
  })
})


