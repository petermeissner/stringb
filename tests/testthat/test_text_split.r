#### text_split ===============================================================
context("text_split")

test_that("text_split works", {
  expect_true({
    length(unlist(text_split("11111111","")))==8
  })
  expect_true({
    length(unlist(text_split(c("1111","1111"),"")))==8
  })
  expect_true({
    length(unlist(text_split(list("11","11","11","11"),"")))==8
  })
  expect_warning({
    text_split(c("1111","1111"),c("","1"))
  })
  expect_warning({
    text_split(c("1","1"),c("","1"), vectorize = TRUE)
  }, NA)
  expect_true({
    all(
      text_split(c("1","1"),c("","1"), vectorize = TRUE)$t==c("1","")
    )
  })
  expect_true({
    class(text_split(c("111"),c("1",2), vectorize = TRUE)$t)=="character"
  })
  expect_true({
    dim(text_split(c("111"),c("1",2), vectorize = TRUE))[1]==4 &
    all(text_split(c("111"),c("1",2), vectorize = TRUE)$t == c("","","",111)) &
    all(text_split(c("111"),c("1",2), vectorize = TRUE)$i == c(1,1,1,1))  &
    all(text_split(c("111"),c("1",2), vectorize = TRUE)$p == c(1,1,1,2))
  })
})

