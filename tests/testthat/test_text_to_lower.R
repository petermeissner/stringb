#### text_to_lower ===============================================================
context("text_to_lower")

test_that("text_to_lower works", {
  expect_true({
    text_to_lower("123")=="123"
  })
  expect_true({
    text_to_lower("abcd")=="abcd"
  })
  expect_true({
    text_to_lower("AbCd")=="abcd"
  })
  expect_true({
    all(text_to_lower(LETTERS)==letters)
  })
  expect_true({
    text_to_lower("\ue4")=="\ue4"
  })
  expect_true({
    text_to_lower("\uc4")=="\ue4"
  })
  expect_equal({
    text_to_lower(
      list(
        "Title Case in the Light of Modern History",
        "Title Case in the Light of Modern History",
        "Title Case in the Light of Modern History"
      )
    )
  },
  list(
    "title case in the light of modern history",
    "title case in the light of modern history",
    "title case in the light of modern history"
  )
  )
})

test_that("text_to_upper works", {
  expect_true({
    text_to_upper("123")=="123"
  })
  expect_true({
    text_to_upper("abcd")=="ABCD"
  })
  expect_true({
    text_to_upper("ABCD")=="ABCD"
  })
  expect_true({
    text_to_upper("AbCd")=="ABCD"
  })
  expect_true({
    all(text_to_upper(letters)==LETTERS)
  })
  expect_true({
    text_to_upper("\ue4")=="\uc4"
  })
  expect_true({
    text_to_upper("\uc4")=="\uc4"
  })
  expect_equal({
    text_to_upper(
      list(
        "Title Case in the Light of Modern History",
        "Title Case in the Light of Modern History",
        "Title Case in the Light of Modern History"
      )
    )
  },
  list(
    "TITLE CASE IN THE LIGHT OF MODERN HISTORY",
    "TITLE CASE IN THE LIGHT OF MODERN HISTORY",
    "TITLE CASE IN THE LIGHT OF MODERN HISTORY"
  )
  )
})


test_that("text_to_title_case works", {
  expect_true({
    text_to_title_case("123")=="123"
  })
  expect_true({
    text_to_title_case("fi fa fom fei")=="Fi Fa Fom Fei"
  })
  expect_true({
    text_to_title_case("title case in the light of modern history")==
      "Title Case in the Light of Modern History"
  })
  expect_equal({
    text_to_title_case(
      list(
        "title case in the light of modern history",
        "title case in the light of modern history",
        "title case in the light of modern history"
      )
    )
  },
    list(
      "Title Case in the Light of Modern History",
      "Title Case in the Light of Modern History",
      "Title Case in the Light of Modern History"
    )
  )
})




















