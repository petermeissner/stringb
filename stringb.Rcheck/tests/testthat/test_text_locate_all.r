

#### text_detect ===============================================================
context("text_locate_all")

test_that("text_locate_all works", {
  expect_true({
    length(text_locate_all(c("",""),""))==2
  })
  expect_warning({
    text_locate_all(c("",""),1:2)
  })
  expect_warning({
    text_locate_all(c("",""),1:2,T)
  },NA)
  expect_warning({
    text_locate_all(c("",""),1:2,vectorize=TRUE)
  },NA)
  expect_true({
    is.list(text_locate_all(c("",""),1:2,vectorize=TRUE))
  })
  expect_true({
    all(
      dim(text_locate_all(c("",""),1:2,vectorize=TRUE, simplify = TRUE)) ==
      c(2,5)
    )
  })
})

test_that("text_locate_all does not ignore ...", {
  expect_true({
    !is.na(
      text_locate_all("abcd", "A", ignore.case=TRUE)[[1]]$start
    )
  })
})
