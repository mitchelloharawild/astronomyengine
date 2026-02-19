test_that("astro_identity_matrix returns proper matrix", {
  mat <- astro_identity_matrix()

  expect_type(mat, "double")
  expect_true(is.matrix(mat))
  expect_equal(dim(mat), c(3, 3))

  # Check it's an identity matrix
  expect_equal(mat[1, 1], 1)
  expect_equal(mat[2, 2], 1)
  expect_equal(mat[3, 3], 1)
  expect_equal(mat[1, 2], 0)
  expect_equal(mat[2, 1], 0)
})

test_that("rotation functions return proper matrices", {
  time <- astro_make_time(2026, 2, 19, 12, 0, 0)

  # Test one rotation function
  rot <- astro_rotation_EQJ_EQD(time)

  expect_type(rot, "double")
  expect_true(is.matrix(rot))
  expect_equal(dim(rot), c(3, 3))
})
