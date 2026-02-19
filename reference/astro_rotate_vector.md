# Apply a rotation to a vector

This function transforms a vector in one orientation to a vector in
another orientation.

## Usage

``` r
astro_rotate_vector(rotation, vector)
```

## Arguments

- rotation:

  A rotation matrix that specifies how the orientation of the vector is
  to be changed

- vector:

  The vector whose orientation is to be changed. A list with components:

  x

  :   The Cartesian x-coordinate in AU

  y

  :   The Cartesian y-coordinate in AU

  z

  :   The Cartesian z-coordinate in AU

  t

  :   The date and time (POSIXct) at which this vector is valid

## Value

A vector in the orientation specified by `rotation`

## Examples

``` r
# Create a vector and rotate it
vec <- list(x = 1, y = 0, z = 0, t = as.POSIXct("2024-01-01", tz = "UTC"))
rot <- astro_identity_matrix()
rotated <- astro_rotate_vector(rot, vec)
```
