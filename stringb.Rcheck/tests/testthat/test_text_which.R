#### text_which ===============================================================
context("text_which")

test_that("text_which works", {
  expect_true({
    text_which("123","1")==1
  })
  expect_true({
    text_which(1:2,"2")==2
  })
  expect_true({
    text_which(c("\ue4"),"\ue4")==1
  })
})

test_that("text_which_value works", {
  expect_true({
    text_which_value("123","1")=="123"
  })
  expect_true({
    text_which_value(1:2,"2")==2
  })
  expect_true({
    text_which_value(c("\ue4    "),"\ue4")=="\ue4    "
  })
})

test_that("text_grep works", {
  expect_true({
    text_grep("123","1")==1
  })
  expect_true({
    text_grep(1:2,"2")==2
  })
  expect_true({
    text_grep(c("\ue4"),"\ue4")==1
  })
})

test_that("text_grepl works", {
  expect_true({
    text_grepl("123","1")==TRUE
  })
  expect_equal({
    text_grepl(1:2,"2")
  }, c(FALSE,TRUE))
  expect_true({
    text_grepl(c("\ue4"),"\ue4")==TRUE
  })
})

test_that("text_grepv works", {
  expect_true({
    text_grepv("123","1")=="123"
  })
  expect_true({
    text_grepv(1:2,"2")==2
  })
  expect_true({
    text_grepv(c("\ue4    "),"\ue4")=="\ue4    "
  })
})

test_that("text_subset works", {
  expect_true({
    text_subset("123","1")=="123"
  })
  expect_true({
    text_subset(1:2,"2")==2
  })
  expect_true({
    text_subset(c("\ue4    "),"\ue4")=="\ue4    "
  })
})

test_that("text_filter works", {
  expect_true({
    text_filter("123","1")=="123"
  })
  expect_true({
    text_filter(1:2,"2")==2
  })
  expect_true({
    text_filter(c("\ue4    "),"\ue4")=="\ue4    "
  })
})

