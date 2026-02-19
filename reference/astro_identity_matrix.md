# Create an identity rotation matrix

Returns a rotation matrix that has no effect on orientation. This matrix
can be the starting point for other operations, such as using a series
of calls to
[`astro_pivot()`](https://pkg.mitchelloharawild.com/astronomyengine/reference/astro_pivot.md)
to create a custom rotation matrix.

## Usage

``` r
astro_identity_matrix()
```

## Value

A list with components:

- rot:

  A 3x3 rotation matrix

- status:

  Status code (0 = success)

## Examples

``` r
# Create an identity matrix
id <- astro_identity_matrix()
id
#>      [,1] [,2] [,3]
#> [1,]    1    0    0
#> [2,]    0    1    0
#> [3,]    0    0    1
```
