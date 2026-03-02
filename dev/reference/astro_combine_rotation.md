# Combine two rotation matrices

Given two rotation matrices, returns a combined rotation matrix that is
equivalent to rotating based on the first matrix, followed by the
second.

## Usage

``` r
astro_combine_rotation(a, b)
```

## Arguments

- a:

  The first rotation to apply

- b:

  The second rotation to apply

## Value

The combined rotation matrix

## Examples

``` r
# Combine two identity matrices (result is also identity)
rot_a <- astro_identity_matrix()
rot_b <- astro_identity_matrix()
combined <- astro_combine_rotation(rot_a, rot_b)
```
