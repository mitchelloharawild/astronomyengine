test_that("astro_body constant contains expected bodies", {
  expect_type(astro_body, "integer")
  expect_true("SUN" %in% names(astro_body))
  expect_true("MOON" %in% names(astro_body))
  expect_true("MARS" %in% names(astro_body))
  expect_true("JUPITER" %in% names(astro_body))

  # Check specific values
  expect_equal(astro_body["SUN"], c(SUN = 9L))
  expect_equal(astro_body["EARTH"], c(EARTH = 2L))
})

test_that("astro_body_name returns correct names", {
  expect_equal(astro_body_name(9L), "Sun")
  expect_equal(astro_body_name(astro_body["SUN"]), "Sun")
  expect_equal(astro_body_name(astro_body["MARS"]), "Mars")
  expect_equal(astro_body_name(astro_body["MOON"]), "Moon")
})

test_that("astro_body_code returns correct codes", {
  expect_equal(astro_body_code("Sun"), 9L)
  expect_equal(astro_body_code("Mars"), 3L)
  expect_equal(astro_body_code("Moon"), 10L)

  # Invalid name should return -1
  expect_equal(astro_body_code("NotAPlanet"), -1L)
})

test_that("astro_body_name and astro_body_code are inverses", {
  # Test round-trip conversions
  for (body_name in c("Sun", "Moon", "Mercury", "Venus", "Mars", "Jupiter")) {
    code <- astro_body_code(body_name)
    name <- astro_body_name(code)
    expect_equal(name, body_name)
  }
})
