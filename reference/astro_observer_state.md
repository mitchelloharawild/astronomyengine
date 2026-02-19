# Observer position and velocity vector from geographic coordinates

Calculates the geocentric equatorial position and velocity vectors of an
observer on the surface of the Earth, taking into account the Earth's
rotation.

## Usage

``` r
astro_observer_state(time, latitude, longitude, height, of_date = FALSE)
```

## Arguments

- time:

  A POSIXct date and time for which to calculate the observer's state
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

- vx:

  Equatorial x-velocity in AU/day

- vy:

  Equatorial y-velocity in AU/day

- vz:

  Equatorial z-velocity in AU/day

- t:

  The time (POSIXct) at which the state vector is valid

- status:

  Status code (0 = success)

The position vector components are expressed in Astronomical Units (AU).
Multiply by \#KM_PER_AU to convert to kilometers. The velocity
components are in AU per day.

If only position is needed without velocity,
[`astro_observer_vector()`](https://pkg.mitchelloharawild.com/astronomyengine/reference/astro_observer_vector.md)
is slightly more efficient.

## Examples

``` r
# Get observer state at Sydney Observatory
time <- as.POSIXct("2024-01-01 12:00:00", tz = "UTC")
obs_state <- astro_observer_state(time, latitude = -33.8688, longitude = 151.2093, height = 0)
obs_state
#> $x
#> [1] 1.11619e-05
#> 
#> $y
#> [1] 3.361475e-05
#> 
#> $z
#> [1] -2.365291e-05
#> 
#> $vx
#> [1] -0.0002117903
#> 
#> $vy
#> [1] 7.067011e-05
#> 
#> $vz
#> [1] 4.893798e-07
#> 
#> $t
#> [1] "2024-01-01 12:00:00 UTC"
#> 
#> $status
#> [1] 0
#> 
```
