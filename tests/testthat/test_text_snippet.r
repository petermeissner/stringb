#### text_snippet ==============================================================
context("text_snippet()")

test_that("text_snippet", {
  tt500 <- paste(rep(0:9,50), collapse = "")
  tt100 <- paste(rep(0:9,10), collapse = "")
  ttvec <- c(tt100, tt500)

  expect_true( nchar(text_snippet(""))==0 )
  expect_true( nchar(text_snippet("", from=2))==0 )
  expect_true( nchar(text_snippet("", to=2))==0 )
  expect_true( nchar(text_snippet("", from=1, to=2))==0 )

  expect_true( nchar(text_snippet(tt100, from=1, to=2))==2 )
  expect_true( nchar(text_snippet(tt100, from=2, to=1))==0 )
  expect_true( nchar(text_snippet(tt100, from=-2, to=0))==0 )
  expect_true( nchar(text_snippet(tt100, from=1, to=-1))==0 )

  expect_true( nchar(text_snippet(tt500))==500 )

  expect_true( nchar(text_snippet(tt100))==100 )
  expect_true( nchar(text_snippet(tt100,50))==50)
  expect_true( nchar(text_snippet(tt100, 50, to=25))==25 )
  expect_true( nchar(text_snippet(tt100, 50, from=25))==50 )
  expect_true( nchar(text_snippet(tt100, 50, from=99))==2 )
  expect_true( nchar(text_snippet(tt100, 50, from=99, to=99))==1 )
  expect_true( nchar(text_snippet(tt100, from=0, to=1))==1 )

  expect_true( nchar(text_snippet(tt500, 50, from=1, to=500))==500 )

  expect_true( all(nchar(text_snippet(ttvec, 50, from=1, to=500))==c(100,500)) )
  expect_true( all(nchar(text_snippet(ttvec, 10))==c(10,10)) )
})

