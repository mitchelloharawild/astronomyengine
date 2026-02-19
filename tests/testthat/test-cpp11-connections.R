test_that("cpp11 time functions work", {
  # Test astro_make_time_
  time <- astro_make_time_(2026, 2, 19, 12, 0, 0)
  expect_type(time, "double")
  expect_true(is.numeric(time))

  # Test astro_current_time_
  current <- astro_current_time_()
  expect_type(current, "double")
  expect_true(current > 0)
})

test_that("cpp11 body functions work", {
  # Test astro_body_code_ with valid body name
  sun_code <- astro_body_code_("Sun")
  expect_type(sun_code, "integer")
  expect_true(sun_code >= 0)

  # Test astro_body_name_ with valid body code
  sun_name <- astro_body_name_(sun_code)
  expect_type(sun_name, "character")
  expect_equal(sun_name, "Sun")

  # Test round-trip conversion
  mercury_code <- astro_body_code_("Mercury")
  mercury_name <- astro_body_name_(mercury_code)
  expect_equal(mercury_name, "Mercury")
})

test_that("cpp11 vector functions work", {
  time <- astro_make_time_(2026, 2, 19, 12, 0, 0)

  # Test astro_helio_vector_
  helio_vec <- astro_helio_vector_(0, time)
  expect_type(helio_vec, "list")
  expect_true("x" %in% names(helio_vec))
  expect_true("y" %in% names(helio_vec))
  expect_true("z" %in% names(helio_vec))

  # Test astro_geo_vector_
  geo_vec <- astro_geo_vector_(0, time, 0)
  expect_type(geo_vec, "list")
  expect_true("x" %in% names(geo_vec))

  # Test astro_sun_position_
  sun_pos <- astro_sun_position_(time)
  expect_type(sun_pos, "list")
  expect_true(length(sun_pos) > 0)
})

test_that("cpp11 lunar functions work", {
  time <- astro_make_time_(2026, 2, 19, 12, 0, 0)

  # Test astro_moon_phase_
  phase <- astro_moon_phase_(time)
  expect_type(phase, "double")
  expect_true(phase >= 0 && phase <= 360)
})

test_that("cpp11 season functions work", {
  # Test astro_seasons_
  seasons <- astro_seasons_(2026)
  expect_type(seasons, "list")
  expect_true(length(seasons) >= 4)
  # Seasons use abbreviated names (mar, jun, sep, dec)
  expect_true("mar_equinox" %in% names(seasons))
  expect_true("jun_solstice" %in% names(seasons))
  expect_true("sep_equinox" %in% names(seasons))
  expect_true("dec_solstice" %in% names(seasons))
})

test_that("cpp11 rotation functions work", {
  # Test astro_identity_matrix_ returns numeric values
  identity <- astro_identity_matrix_()
  expect_type(identity, "double")

  time <- astro_make_time_(2026, 2, 19, 12, 0, 0)

  # Test astro_rotation_eqd_eqj_ returns numeric rotation data
  rotation <- astro_rotation_eqd_eqj_(time)
  expect_type(rotation, "double")
})

test_that("cpp11 equatorial coordinate functions work", {
  time <- astro_make_time_(2026, 2, 19, 12, 0, 0)

  # Test astro_equator_
  equator <- astro_equator_(0, time, 40, -74, 0, FALSE, FALSE)
  expect_type(equator, "list")
  expect_true("ra" %in% names(equator) || "ra_hours" %in% names(equator))
})

test_that("cpp11 elongation functions work", {
  time <- astro_make_time_(2026, 2, 19, 12, 0, 0)

  # Test astro_angle_from_sun_
  angle <- astro_angle_from_sun_(1, time)
  expect_type(angle, "double")
  expect_true(angle >= 0 && angle <= 180)

  # Test astro_elongation_
  elongation <- astro_elongation_(1, time)
  expect_type(elongation, "list")
})

test_that("cpp11 functions return consistent types", {
  time <- astro_make_time_(2026, 2, 19, 12, 0, 0)

  # Verify double returns
  expect_type(astro_ecliptic_longitude_(0, time), "double")
  expect_type(astro_helio_distance_(1, time), "double")

  # Verify list returns
  expect_type(astro_bary_state_(0, time), "list")
  expect_type(astro_observer_vector_(time, 40, -74, 0, FALSE), "list")
  expect_type(astro_observer_state_(time, 40, -74, 0, FALSE), "list")
})
