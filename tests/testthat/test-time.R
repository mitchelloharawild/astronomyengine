test_that("astro_make_time creates proper POSIXct objects", {
  # Basic usage
  time <- astro_make_time(2026, 2, 19)
  expect_s3_class(time, "POSIXct")
  expect_equal(attr(time, "tzone"), "UTC")

  # With hours, minutes, seconds
  time_full <- astro_make_time(2026, 2, 19, 12, 30, 45.5)
  expect_s3_class(time_full, "POSIXct")
  expect_true(time_full > time)

  # Check that time is reasonable
  expect_true(as.numeric(time) > 0)
})

test_that("astro_current_time returns current time", {
  current <- astro_current_time()
  expect_s3_class(current, "POSIXct")
  expect_equal(attr(current, "tzone"), "UTC")

  # Should be close to system time (within a few seconds)
  sys_time <- as.POSIXct(Sys.time(), tz = "UTC")
  diff_seconds <- abs(as.numeric(current) - as.numeric(sys_time))
  expect_true(diff_seconds < 5)
})
