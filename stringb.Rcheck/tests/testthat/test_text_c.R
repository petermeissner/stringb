#### text_c ===============================================================
context("text_c")

test_that("text_c works", {
  expect_true({
    text_c(1,2,3)=="123"
  })
  expect_true({
    text_c("\ue4")=="\ue4"
  })
  expect_true({
    text_c(1:10, coll="")=="12345678910"
  })
  expect_true({
    text_c(1:3,1, coll="")=="112131"
  })
  expect_equal({
    text_c(1:3,1, sep=" ")
  }, c("1 1", "2 1", "3 1"))
  expect_equal({
    text_c(1:3,1, sep="", coll=" ")
  }, "11 21 31")
})



test_that("%.% works", {
  expect_true({
    "\ue4" %.% "\ue4" == "\ue4\ue4"
  })
})



test_that("%..% works", {
  expect_true({
    "\ue4" %..% "\ue4" == "\ue4 \ue4"
  })
  expect_equal({
    1:2 %..% "1"
  }, c("1 1", "2 1"))
})
