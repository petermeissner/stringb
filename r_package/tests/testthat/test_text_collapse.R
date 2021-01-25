#### text_collapse ===============================================================
context("text_collapse")

test_that("text_collapse works works", {
  expect_true({
    text_collapse(1)==1
  })
  expect_true({
    text_collapse("\u00df\u03b2")=="\u00df\u03b2"
  })
  expect_true({
    text_collapse(list(list(1,2,3),list(letters)))=="123abcdefghijklmnopqrstuvwxyz"
  })
  expect_true({
    text_collapse(data.frame(1:4,1:4))=="11223344"
  })
  expect_true({
    text_collapse(data.frame(1:4,1:4), coll = "/")=="1/1/2/2/3/3/4/4"
  })
  expect_true({
    text_collapse(data.frame(1:4,1:4), coll = c(", ","\n"))=="1, 1\n2, 2\n3, 3\n4, 4"
  })
  expect_true({
    text_collapse(as.matrix(data.frame(1:4,1:4)), coll = c(", ","\n"))=="1, 1\n2, 2\n3, 3\n4, 4"
  })
  expect_true({
    text_collapse(as.list(data.frame(1:4,1:4)))=="12341234"
  })
})


