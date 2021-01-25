#### text_read =================================================================
context("text_read()")

test_that("text_read", {
  expect_true(
    any(
      Encoding(
        text_read(test_file("test_latin1.txt"), encoding = "latin1")
      ) == "UTF-8"
    )
  )
  expect_true( any(Encoding(text_read(test_file("test_utf8.txt"))) == "UTF-8"))
  expect_true( any(Encoding(text_read(test_file("test_latin1.txt"), encoding="latin1")) == "UTF-8"))
  expect_true( any(Encoding(text_read(test_file("test_utf8.txt"), encoding="latin1")) == "UTF-8"))
  expect_true(
    all(
      nchar(text_read(test_file("test_utf8.txt"), encoding="UTF-8")) ==
      nchar(text_read(test_file("test_latin1.txt"), encoding="latin1"))
    )
  )
  expect_true( length(text_read(test_file("test_utf8.txt"), encoding="latin1", tokenize=NULL))==1 )
  expect_true( length(text_read(test_file("test_utf8.txt"), tokenize = "\n"))>1 )
  expect_true( length(text_read(test_file("test_utf8.txt"), tokenize = " "))>1 )
  expect_true( length(text_read(test_file("test_utf8.txt"), tokenize = function(x){strsplit(x,"")} ))>1 )
})

