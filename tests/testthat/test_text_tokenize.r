#### text_tokenize =============================================================
context("text_tokenize()")

test_that("text_tokenize", {
  expect_true(
    dim(text_tokenize("abcdefg", regex="\\W+"))[1]==1
  )
  expect_true({
    text_tokenize(" ", regex=""); TRUE
  })
  expect_true({
    text_tokenize("", regex=""); TRUE
   })
  expect_true({
    text_tokenize("  ", regex=" "); TRUE
  })
})



