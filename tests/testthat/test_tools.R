#### tools ===============================================================
context("\ntools")
#### tools ===============================================================




#### cuts_to_spans ===============================================================
context("tools cuts_to_spans()")
test_that("cuts_to_spans work", {
  expect_true({
    all(dim(cuts_to_spans(1:100, end=100))==c(100,2))
  })
  expect_true({
    all(dim(cuts_to_spans(1:100))==c(101,2))
  })
  expect_true({
    all(
      cuts_to_spans(1,end=2)$from == 1:2 &
      cuts_to_spans(1,end=2)$to   == 1:2
    )
  })
  expect_true({
    all(
      unlist(cuts_to_spans(1:100, start=100, end=100))==100
    )
  })
})




