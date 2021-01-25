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
  expect_true({
    all(
      text_tokenize("meine mudder", "M", ignore.case = TRUE)$token ==
      c("eine ", "udder"),
      text_tokenize("meine mudder", "m", ignore.case = FALSE)$token ==
        text_tokenize("meine mudder", "M", ignore.case = TRUE)$token
    )
  })
  expect_true({
    !is.na(text_tokenize("one line of code", "\n")$token)
  })
})



