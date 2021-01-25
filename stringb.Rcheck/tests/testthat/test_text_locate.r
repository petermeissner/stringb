#### text_locate ===============================================================
context("text_locate")

test_that("text_locate works", {
  expect_true({
    all(
      dim(text_locate("",""))==c(1,3)
    )
  })
  expect_true({
    text_locate("001","1")$start==3 &
    text_locate("001","1")$length==1 &
    text_locate("001","1")$end==3
  })
  expect_true({
    text_locate("001",".*")$start==1 &
    text_locate("001",".*")$length==3 &
    text_locate("001",".*")$end==3
  })
  expect_true({
    text_locate("001","0*")$start==1 &
    text_locate("001","0*")$length==2 &
    text_locate("001","0*")$end==2
  })
  expect_true({
    text_locate("001","0*$")$start==4 &
    is.na(text_locate("001","0*$")$end) &
    text_locate("001","0*$")$length==0
  })
  expect_true({
    text_locate("001","")$start==1 &
    is.na(text_locate("001","")$end) &
    text_locate("001","")$length==0
  })
  expect_true({
    dim(text_locate(1:3,"1"))[1]==3
  })
  expect_true({
    identical(text_locate(1:3,"1")$start, c(1L, NA, NA))
  })
  expect_true({
    text_locate("\ue4","\ue4")$start==1 &
    is.na(text_locate("001","")$end) &
    text_locate("001","")$length==0
  })
})

test_that("text_locate does not ignore ...", {
  expect_true({
    !is.na(text_locate("abcd", "A", ignore.case=TRUE)$start)
  })
})

