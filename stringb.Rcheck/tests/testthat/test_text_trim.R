#### text_trim =================================================================
context("text_trim")

test_that("text_trim works",
{
  expect_equal({text_trim("  4   ")}, "4")
  expect_equal({text_trim("  4   ", side="b")}, "4")
  expect_equal({text_trim("  4   ", side="both")}, "4")
  expect_equal({text_trim("  4   ", side="b")}, "4")
  expect_equal({text_trim("  4   ", side="l")}, "4   ")
  expect_equal({text_trim("  4   ", side="left")}, "4   ")
  expect_error({text_trim("  4   ", side="lef")})
  expect_equal({text_trim("  4", side="r")}, "  4")
  expect_equal({text_trim("  4", side="right")}, "  4")
  expect_equal({text_trim(as.character(1:10), side="right")}, as.character(1:10))
  expect_equal({text_trim(as.character(1:10), side="left")}, as.character(1:10))
  expect_equal({text_trim(as.character(1:10), side="both")}, as.character(1:10))
  expect_equal({
    text_trim( list("  4  ","       4 ","  4") )
  }, list("4","4","4"))
  expect_equal({
    text_trim( list(list("  4  ", "4"),"       4 ","  4") )
  }, list(list("4", "4"),"4","4"))
  expect_equal({text_trim(1:10, side="both")}, as.character(1:10))
})
