#### text_count ===============================================================
context("text_count")

test_that("text_count works", {
  expect_true({
    text_count("11111111","")==8
  })
  expect_true({
    sum(text_count(rep(1,8),""))==8
  })
  expect_true({
    text_count(rep(1,8),"", sum=TRUE)==8
  })
  expect_true({
    sum(text_count("12345678",1:8, vectorize = TRUE)$n)==8
  })
  expect_true({
    text_count("12345678",1:8, vectorize = TRUE, sum=TRUE)==8
  })
})
