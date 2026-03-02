# Heliocentric position vector of a celestial body

Calculates the position of a celestial body as a vector using the center
of the Sun as the origin. The result is expressed as a Cartesian vector
in the J2000 equatorial system (the mean equator of the Earth at noon
UTC on 1 January 2000).

## Usage

``` r
astro_helio_vector(body, time)
```

## Arguments

- body:

  Identifier of celestial body (e.g., `astro_body[["SUN"]]`,
  `astro_body[["MARS"]]`).

- time:

  A POSIXct time value.

## Value

A list with elements:

- x:

  X coordinate in AU.

- y:

  Y coordinate in AU.

- z:

  Z coordinate in AU.

- time:

  Observation time as POSIXct.

## Details

The position is not corrected for light travel time or aberration.

## Examples

``` r
time <- as.POSIXct("2025-02-19 22:10:12", tz = "UTC")
astro_helio_vector(astro_body[["MARS"]], time)
#> $x
#> [1] -1.094507
#> 
#> $y
#> [1] 1.11158
#> 
#> $z
#> [1] 0.5393855
#> 
#> $time
#> [1] "2025-02-19 22:10:12 UTC"
#> 
```
