#### text_count ===============================================================
context("text_count")

test_that("text_count works", {
  expect_true({
    text_count("11111111","")==8
  })
  expect_true({
    sum(text_count(rep(1,8),""))==8
  })
  expect_true({
    text_count(rep(1,8),"", sum=TRUE)==8
  })
  expect_true({
    sum(text_count("12345678",1:8, vectorize = TRUE)$n)==8
  })
  expect_true({
    text_count("12345678",1:8, vectorize = TRUE, sum=TRUE)==8
  })
})


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




#### text_detect ===============================================================
context("text_locate_all")

test_that("text_locate_all works", {
  expect_true({
    length(text_locate_all(c("",""),""))==2
  })
  expect_warning({
    text_locate_all(c("",""),1:2)
  })
  expect_warning({
    text_locate_all(c("",""),1:2,T)
  },NA)
  expect_warning({
    text_locate_all(c("",""),1:2,vectorize=TRUE)
  },NA)
  expect_true({
    is.list(text_locate_all(c("",""),1:2,vectorize=TRUE))
  })
  expect_true({
    all(
      dim(text_locate_all(c("",""),1:2,vectorize=TRUE, simplify = TRUE)) ==
      c(2,5)
    )
  })
})




#### text_detect ===============================================================
context("text_detect")

test_that("text_read", {
  expect_true(
    length(text_read(stringb_tf(1)))==length(text_detect(text_read(stringb_tf(1)),""))
  )
  expect_true(
    any(
      text_detect(
        text_read(stringb_tf("test_latin1.txt"), encoding="latin1"),
        "\ue4 \uf6 \ufc \udf"
      )
    )
  )
  expect_true(
    any(
      text_detect(
        text_read(stringb_tf("test_utf8.txt")),
        "\ue4 \uf6 \ufc \udf"
      )
    )
  )
})



#### text_read =================================================================
context("text_read()")

test_that("text_read", {
  expect_true(
    any(
      Encoding(
        text_read(stringb_tf("test_latin1.txt"), encoding = "latin1")
      ) == "UTF-8"
    )
  )
  expect_true( any(Encoding(text_read(stringb_tf("test_utf8.txt"))) == "UTF-8"))
  expect_true( any(Encoding(text_read(stringb_tf("test_latin1.txt"), encoding="latin1")) == "UTF-8"))
  expect_true( any(Encoding(text_read(stringb_tf("test_utf8.txt"), encoding="latin1")) == "UTF-8"))
  expect_true(
    all(
      nchar(text_read(stringb_tf("test_utf8.txt"), encoding="UTF-8")) ==
      nchar(text_read(stringb_tf("test_latin1.txt"), encoding="latin1"))
    )
  )
  expect_true( length(text_read(stringb_tf("test_utf8.txt"), encoding="latin1", tokenize=NULL))==1 )
  expect_true( length(text_read(stringb_tf("test_utf8.txt"), tokenize = "\n"))>1 )
  expect_true( length(text_read(stringb_tf("test_utf8.txt"), tokenize = " "))>1 )
  expect_true( length(text_read(stringb_tf("test_utf8.txt"), tokenize = function(x){strsplit(x,"")} ))>1 )
})



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



