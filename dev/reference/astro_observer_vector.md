# Observer position vector from geographic coordinates

Calculates the geocentric equatorial position vector of an observer on
the surface of the Earth, taking into account the Earth's rotation. This
is the inverse function of
[`astro_vector_observer()`](https://pkg.mitchelloharawild.com/astronomyengine/dev/reference/astro_vector_observer.md).

## Usage

``` r
astro_observer_vector(time, latitude, longitude, height, of_date = FALSE)
```

## Arguments

- time:

  A POSIXct date and time for which to calculate the observer's position
  vector.

- latitude:

  The geographic latitude of the observer in degrees north of the
  equator (range: -90 to +90).

- longitude:

  The geographic longitude of the observer in degrees east of the prime
  meridian (range: 0 to 360 or -180 to +180).

- height:

  The elevation of the observer above sea level in meters.

- of_date:

  Logical. If `TRUE`, uses equator-of-date coordinates (Earth's equator
  at the given time). If `FALSE` (default), uses J2000 coordinates
  (Earth's equator on 2000-01-01).

## Value

A list with components:

- x:

  Equatorial x-coordinate in AU

- y:

  Equatorial y-coordinate in AU

- z:

  Equatorial z-coordinate in AU

- t:

  The time (POSIXct) at which the vector is valid

- status:

  Status code (0 = success)

The vector represents the displacement from Earth's center to the
observer, expressed in Astronomical Units (AU). Multiply by \#KM_PER_AU
to convert to kilometers.

## Examples

``` r
# Get observer position at Sydney Observatory
time <- as.POSIXct("2024-01-01 12:00:00", tz = "UTC")
obs_vec <- astro_observer_vector(time, latitude = -33.8688, longitude = 151.2093, height = 0)
obs_vec
#> $x
#> [1] 1.11619e-05
#> 
#> $y
#> [1] 3.361475e-05
#> 
#> $z
#> [1] -2.365291e-05
#> 
#> $t
#> [1] "2024-01-01 12:00:00 UTC"
#> 
#> $status
#> [1] 0
#> 
```
