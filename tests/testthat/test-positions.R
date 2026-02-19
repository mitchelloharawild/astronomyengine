test_that("astro_helio_vector returns proper structure", {
  time <- astro_make_time(2026, 2, 19, 12, 0, 0)
  vec <- astro_helio_vector(astro_body["MARS"], time)

  expect_type(vec, "list")
  expect_true("x" %in% names(vec))
  expect_true("y" %in% names(vec))
  expect_true("z" %in% names(vec))
  expect_true("time" %in% names(vec))

  # Check types
  expect_type(vec$x, "double")
  expect_type(vec$y, "double")
  expect_type(vec$z, "double")
  expect_s3_class(vec$time, "POSIXct")
})

test_that("astro_sun_position returns proper structure", {
  time <- astro_make_time(2026, 2, 19, 12, 0, 0)
  pos <- astro_sun_position(time)

  expect_type(pos, "list")
  expect_true("elon" %in% names(pos) || "ecliptic_longitude" %in% names(pos))
  expect_true("elat" %in% names(pos) || "ecliptic_latitude" %in% names(pos))
})

test_that("astro_elongation returns proper structure", {
  time <- astro_make_time(2026, 2, 19, 12, 0, 0)

  # Test with Venus
  elong <- astro_elongation(astro_body["VENUS"], time)

  expect_type(elong, "list")
  expect_true("elongation" %in% names(elong))
  expect_type(elong$elongation, "double")
})

test_that("astro_angle_from_sun returns valid angles", {
  time <- astro_make_time(2026, 2, 19, 12, 0, 0)

  # Test with Mars
  angle <- astro_angle_from_sun(astro_body["MARS"], time)

  expect_type(angle, "double")
  expect_true(angle >= 0)
  expect_true(angle <= 180)
})

test_that("astro_equator returns proper structure", {
  time <- astro_make_time(2026, 2, 19, 12, 0, 0)

  # Test with Sun
  equator <- astro_equator(
    astro_body["SUN"],
    time,
    latitude = 40,
    longitude = -74,
    height = 0
  )

  expect_type(equator, "list")
  expect_true("ra" %in% names(equator) || "ra_hours" %in% names(equator))
  expect_true("dec" %in% names(equator) || "declination" %in% names(equator))
})

test_that("astro_horizon returns proper structure", {
  time <- astro_make_time(2026, 2, 19, 12, 0, 0)

  # astro_horizon takes ra/dec, not a body
  # First get equatorial coordinates, then convert to horizon
  equator <- astro_equator(
    astro_body["SUN"],
    time,
    latitude = 40,
    longitude = -74,
    height = 0
  )

  horizon <- astro_horizon(
    time,
    latitude = 40,
    longitude = -74,
    ra = equator$ra,
    dec = equator$dec
  )

  expect_type(horizon, "list")
  expect_true("azimuth" %in% names(horizon))
  expect_true("altitude" %in% names(horizon))
})
