# Search for when a body reaches a specified hour angle

Searches for the time when the center of a body reaches a specified hour
angle as seen by an observer on the Earth. The hour angle is 0 when the
body reaches its highest point (culmination) above the horizon in a
given day.

## Usage

``` r
astro_search_hour_angle(
  body,
  time,
  latitude,
  longitude,
  height = 0,
  hour_angle = 0,
  direction = 1L
)
```

## Arguments

- body:

  Integer body code (see
  [astro_body](https://pkg.mitchelloharawild.com/astronomyengine/dev/reference/astro_body.md)).

- time:

  A `POSIXct` date/time in UTC to start the search from.

- latitude:

  Observer's geographic latitude in degrees.

- longitude:

  Observer's geographic longitude in degrees.

- height:

  Observer's height above sea level in metres. Default `0`.

- hour_angle:

  An hour angle value in the range \[0, 24) indicating the number of
  sidereal hours after the body's most recent culmination. Default `0`
  (culmination).

- direction:

  `1L` to search forward in time, `-1L` to search backward. Default `1L`
  (forward).

## Value

A list with elements:

- time:

  `POSIXct` time of the event.

- azimuth:

  Azimuth angle in degrees (0° = North, 90° = East).

- altitude:

  Altitude angle in degrees above the horizon.

## Details

To find when a body culminates (reaches maximum altitude), use
`hour_angle = 0`. To find when a body reaches its minimum altitude, use
`hour_angle = 12`.

## Examples

``` r
t <- as.POSIXct("2025-06-21", tz = "UTC")
# Find when the Sun culminates (hour_angle = 0)
astro_search_hour_angle(astro_body[["SUN"]], t,
                        latitude = -33.8688, longitude = 151.2093)
#> $time
#> [1] "2025-06-21 01:56:55 UTC"
#> 
#> $azimuth
#> [1] 0.0002579293
#> 
#> $altitude
#> [1] 32.71702
#> 
```
