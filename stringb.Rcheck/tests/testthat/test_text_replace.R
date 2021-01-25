#### text_replace =================================================================
context("text_replace")

test_that("text_replace works",
          {
            expect_equal(
              text_replace("1,2,1,1", "2", "1"),
            "1,1,1,1")
            expect_equal(
              text_replace("1,2,2,1", "2", "1"),
            "1,1,2,1")
            expect_error({
              text_replace()
            })
            expect_error({
              text_replace("")
            })
            expect_error({
              text_replace("","")
            })
            expect_error({
              text_replace("","","")
            },NA)
            expect_equal({
              text_replace("","1","1")
            },"")
          }
        )


test_that("text_replace_all works",
          {
            expect_equal(
              text_replace_all("1,2,1,1", "2", "1"),
              "1,1,1,1")
            expect_equal(
              text_replace_all("1,2,2,1", "2", "1"),
              "1,1,1,1")
            expect_error({
              text_replace_all()
            })
            expect_error({
              text_replace_all("")
            })
            expect_error({
              text_replace_all("","")
            })
            expect_error({
              text_replace_all("","","")
            },NA)
            expect_equal({
              text_replace_all("","1","1")
            },"")
          }
)


test_that("text_delete works",
          {
            expect_equal(
              text_delete("1,2,1,1", "2"),
              "1,,1,1")
            expect_equal(
              text_delete("1,2,2,1", "2", "1"),
              "1,,2,1")
            expect_error({
              text_delete()
            })
            expect_error({
              text_delete("")
            })
            expect_error({
              text_delete("","")
            },NA)
            expect_equal({
              text_delete("","1")
            },"")
          }
)
