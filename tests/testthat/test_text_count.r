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
  expect_equal({
    unlist(text_count(list("12345678", list(list("a",1:10))),1, sum=TRUE))
  }, c(1,0,2))
  expect_equal({
    text_count(list("12345678", 1:4),1)
  }, list(1, c(1,0,0,0)))
})
