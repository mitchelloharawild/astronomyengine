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

test_that("astro_vector_from_sphere and astro_sphere_from_vector are inverses", {
  time <- as.POSIXct("2026-02-19 12:00:00", tz = "UTC")
  
  # Test with various spherical coordinates
  test_cases <- list(
    list(lat = 0, lon = 0, dist = 1),
    list(lat = 45, lon = 90, dist = 1.5),
    list(lat = -30, lon = 180, dist = 2.0),
    list(lat = 89.9, lon = 270, dist = 0.5)
  )
  
  for (sphere_orig in test_cases) {
    # sphere -> vector -> sphere
    vec <- astro_vector_from_sphere(sphere_orig, time)
    sphere_back <- astro_sphere_from_vector(vec)
    
    expect_equal(sphere_back$lat, sphere_orig$lat, tolerance = 1e-10)
    expect_equal(sphere_back$lon, sphere_orig$lon, tolerance = 1e-10)
    expect_equal(sphere_back$dist, sphere_orig$dist, tolerance = 1e-10)
  }
})

test_that("astro_equator_from_vector and astro_vector_from_sphere roundtrip", {
  time <- as.POSIXct("2026-02-19 12:00:00", tz = "UTC")
  
  # Create a vector
  vec_orig <- list(x = 1.0, y = 0.5, z = 0.25, t = time)
  
  # vector -> equator -> sphere -> vector
  equ <- astro_equator_from_vector(vec_orig)
  
  # Convert to sphere format (RA in degrees, dec, dist)
  sphere <- list(
    lat = equ$dec,
    lon = equ$ra * 15,  # Convert hours to degrees
    dist = equ$dist
  )
  
  vec_back <- astro_vector_from_sphere(sphere, time)
  
  expect_equal(vec_back$x, vec_orig$x, tolerance = 1e-10)
  expect_equal(vec_back$y, vec_orig$y, tolerance = 1e-10)
  expect_equal(vec_back$z, vec_orig$z, tolerance = 1e-10)
})

test_that("astro_horizon_from_vector and astro_vector_from_horizon are inverses", {
  time <- as.POSIXct("2026-02-19 12:00:00", tz = "UTC")
  
  # Test with various horizontal coordinates (no refraction for exact inverse)
  test_cases <- list(
    list(lat = 0, lon = 0, dist = 1),      # North horizon
    list(lat = 45, lon = 90, dist = 1),    # East, 45° altitude
    list(lat = 30, lon = 180, dist = 1.5), # South, 30° altitude
    list(lat = 60, lon = 270, dist = 2.0)  # West, 60° altitude
  )
  
  for (hor_orig in test_cases) {
    # horizon -> vector -> horizon (without refraction)
    vec <- astro_vector_from_horizon(hor_orig, time, refraction = 0)
    hor_back <- astro_horizon_from_vector(vec, refraction = 0)
    
    expect_equal(hor_back$lat, hor_orig$lat, tolerance = 1e-10)
    expect_equal(hor_back$lon, hor_orig$lon, tolerance = 1e-10)
    expect_equal(hor_back$dist, hor_orig$dist, tolerance = 1e-10)
  }
})

test_that("coordinate conversions preserve distance", {
  time <- as.POSIXct("2026-02-19 12:00:00", tz = "UTC")
  
  # Test that distance is preserved through conversions
  original_dist <- 2.5
  sphere <- list(lat = 30, lon = 60, dist = original_dist)
  
  # sphere -> vector
  vec <- astro_vector_from_sphere(sphere, time)
  calculated_dist <- sqrt(vec$x^2 + vec$y^2 + vec$z^2)
  expect_equal(calculated_dist, original_dist, tolerance = 1e-10)
  
  # vector -> sphere
  sphere_back <- astro_sphere_from_vector(vec)
  expect_equal(sphere_back$dist, original_dist, tolerance = 1e-10)
  
  # equator preserves distance
  equ <- astro_equator_from_vector(vec)
  expect_equal(equ$dist, original_dist, tolerance = 1e-10)
})

test_that("coordinate conversions handle edge cases", {
  time <- as.POSIXct("2026-02-19 12:00:00", tz = "UTC")
  
  # North pole
  north_pole <- list(lat = 90, lon = 0, dist = 1)
  vec_north <- astro_vector_from_sphere(north_pole, time)
  expect_equal(vec_north$z, 1, tolerance = 1e-10)
  expect_equal(sqrt(vec_north$x^2 + vec_north$y^2), 0, tolerance = 1e-10)
  
  # South pole
  south_pole <- list(lat = -90, lon = 0, dist = 1)
  vec_south <- astro_vector_from_sphere(south_pole, time)
  expect_equal(vec_south$z, -1, tolerance = 1e-10)
  expect_equal(sqrt(vec_south$x^2 + vec_south$y^2), 0, tolerance = 1e-10)
  
  # Equator at prime meridian
  equator_pm <- list(lat = 0, lon = 0, dist = 1)
  vec_eq <- astro_vector_from_sphere(equator_pm, time)
  expect_equal(vec_eq$x, 1, tolerance = 1e-10)
  expect_equal(vec_eq$z, 0, tolerance = 1e-10)
})
