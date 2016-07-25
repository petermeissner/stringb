#### text_detect ===============================================================
context("text_detect")

test_that("text_detect", {
  expect_true(
    length(text_read(test_file(1)))==length(text_detect(text_read(test_file(1)),""))
  )
  expect_true(
    any(
      text_detect(
        text_read(test_file("test_latin1.txt"), encoding="latin1"),
        "\ue4 \uf6 \ufc \udf"
      )
    )
  )
  expect_true(
    any(
      text_detect(
        text_read(test_file("test_utf8.txt")),
        "\ue4 \uf6 \ufc \udf"
      )
    )
  )
})

