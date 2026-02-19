test_that("astro_seasons returns POSIXct objects", {
  seasons <- astro_seasons(2026)

  expect_type(seasons, "list")
  expect_length(seasons, 4)

  # Check all expected names
  expect_true("mar_equinox" %in% names(seasons))
  expect_true("jun_solstice" %in% names(seasons))
  expect_true("sep_equinox" %in% names(seasons))
  expect_true("dec_solstice" %in% names(seasons))

  # Check all are POSIXct
  for (season in seasons) {
    expect_s3_class(season, "POSIXct")
  }

  # Check ordering (mar < jun < sep < dec)
  expect_true(seasons$mar_equinox < seasons$jun_solstice)
  expect_true(seasons$jun_solstice < seasons$sep_equinox)
  expect_true(seasons$sep_equinox < seasons$dec_solstice)
})

test_that("astro_moon_phase returns valid phase angles", {
  time <- astro_make_time(2026, 2, 19, 12, 0, 0)
  phase <- astro_moon_phase(time)

  expect_type(phase, "double")
  expect_true(phase >= 0)
  expect_true(phase < 360)
})
