#### text_rep ===============================================================
context("text_dup test_rep")

test_that("text_dup text_rep", {
  expect_true({
    all(
      text_dup(letters[1:2],1)==c("a","b")
    )
  })
  expect_error({
      text_dup(letters[1:2])
  })
  expect_true({
    all(
      text_dup(letters[1:2],2)==c("aa","bb")
    )
  })
  expect_true({
    all(
      text_dup(c("bubbu","\ue4"),2)==c("bubbububbu","\ue4\ue4")
    )
  })
  expect_true({
    all(
      text_dup(list(1:4, 1:2),4)[[1]]==c("1111","2222","3333","4444")
    )
  })
  expect_true({
    all(
      text_dup(list(1:4, 1:2),4)[[2]]==c("1111","2222")
    )
  })
  expect_true({
    all(
      text_dup(list(1:4, 1:2),4:1, vectorize = TRUE)[[1]]$i==1:4
    )
  })
  expect_true({
    all(
      text_dup(list(1:4, 1:2),4:1, vectorize = TRUE)[[1]]$i==1:4
    )
  })
  expect_true({
    all(
      text_dup(list(1:2, 1:4),4:1, vectorize = TRUE)[[1]]$i==c(1,2,1,2)
    )
  })
  expect_true({
    all(
      text_dup(list(1:4, 1:2),1:2, vectorize = TRUE)[[1]]$p==c(1,2,1,2)
    )
  })
  expect_true({
    class(text_dup(list(1:4, 1:2),4:1, vectorize = TRUE)[[1]]$t)=="character"
  })
  expect_true({
    all(
      text_dup(list(1:4, 1:2),4:1, vectorize = TRUE)[[1]]$t==c("1111","222","33","4")
    )
  })
  expect_true({
    all(
      text_dup(list(1:4, 1:2),4:1, vectorize = TRUE)[[2]]$t==c("1111","222","11","2")
    )
  })
})


