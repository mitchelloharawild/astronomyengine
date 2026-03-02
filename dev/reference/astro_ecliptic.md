# Convert J2000 equatorial coordinates to ecliptic coordinates

Converts equatorial coordinates in the J2000 frame (mean equator of
Earth at noon UTC on 1 January 2000) to true ecliptic coordinates of
date (relative to the plane of Earth's orbit on the given date).

## Usage

``` r
astro_ecliptic(x, y, z, time)
```

## Arguments

- x:

  X coordinate in AU.

- y:

  Y coordinate in AU.

- z:

  Z coordinate in AU.

- time:

  A POSIXct time value.

## Value

A list with elements:

- x:

  X coordinate (Cartesian) in ecliptic frame in AU.

- y:

  Y coordinate (Cartesian) in ecliptic frame in AU.

- z:

  Z coordinate (Cartesian) in ecliptic frame in AU.

- lon:

  Ecliptic longitude in degrees.

- lat:

  Ecliptic latitude in degrees.

- dist:

  Distance in AU.

- time:

  Observation time as POSIXct.

## Examples

``` r
time <- as.POSIXct("2025-02-19 22:10:12", tz = "UTC")
astro_ecliptic(1.0, 0.5, 0.2, time)
#> $x
#> [1] 0.9966785
#> 
#> $y
#> [1] 0.5444227
#> 
#> $z
#> [1] -0.01535618
#> 
#> $lon
#> [1] 28.645
#> 
#> $lat
#> [1] -0.7746832
#> 
#> $time
#> [1] "2025-02-19 22:10:12 UTC"
#> 
```
