test_that("time values work across different functions", {
  # Create a time and use it in multiple functions
  time <- astro_make_time(2026, 6, 21, 12, 0, 0)

  # Should work with all time-dependent functions
  expect_no_error(astro_moon_phase(time))
  expect_no_error(astro_sun_position(time))
  expect_no_error(astro_helio_vector(astro_body["MARS"], time))
  expect_no_error(astro_angle_from_sun(astro_body["JUPITER"], time))
})

test_that("body codes work consistently across functions", {
  time <- astro_make_time(2026, 2, 19, 12, 0, 0)
  mars_code <- astro_body["MARS"]

  # Should work with both named and integer codes
  vec1 <- astro_helio_vector(mars_code, time)
  vec2 <- astro_helio_vector(3L, time)

  expect_equal(vec1$x, vec2$x)
  expect_equal(vec1$y, vec2$y)
  expect_equal(vec1$z, vec2$z)
})
