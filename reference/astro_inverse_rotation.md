# Calculate the inverse of a rotation matrix

Given a rotation matrix that performs some coordinate transform, this
function returns the matrix that reverses that transform.

## Usage

``` r
astro_inverse_rotation(rotation)
```

## Arguments

- rotation:

  A rotation matrix (list with `rot` component) as returned by
  [`astro_identity_matrix()`](https://pkg.mitchelloharawild.com/astronomyengine/reference/astro_identity_matrix.md)
  or other rotation functions

## Value

A rotation matrix that performs the opposite transformation

## Examples

``` r
# Create a rotation and invert it
rot <- astro_identity_matrix()
inv <- astro_inverse_rotation(rot)
```
