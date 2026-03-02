# Search for when a body reaches a specified altitude

Finds when the center of a given body ascends or descends through a
given altitude angle, as seen by an observer at the specified location
on the Earth.

## Usage

``` r
astro_search_altitude(
  body,
  time,
  latitude,
  longitude,
  height = 0,
  direction = 1L,
  limit_days = 1,
  altitude = 0
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

- direction:

  `1L` to find the body ascending, `-1L` to find descending. Default
  `1L` (ascending).

- limit_days:

  Maximum number of days to search. When positive, searches forward in
  time; when negative, searches backward. Default `1`.

- altitude:

  The desired altitude angle above (positive) or below (negative) the
  observer's local horizon, in degrees. Must be in the range \[-90,
  +90\].

## Value

A `POSIXct` value in UTC, or `NA` if no event is found within
`limit_days`.

## Details

This function is useful for finding twilight times. For example:

- Civil dawn: `direction = 1, altitude = -6`

- Civil dusk: `direction = -1, altitude = -6`

- Nautical twilight: `altitude = -12`

- Astronomical twilight: `altitude = -18`

## Examples

``` r
t <- as.POSIXct("2025-06-21", tz = "UTC")
# Find civil dawn (Sun at -6 degrees)
astro_search_altitude(astro_body[["SUN"]], t,
                      latitude = -33.8688, longitude = 151.2093,
                      direction = 1L, altitude = -6)
#> [1] "2025-06-21 20:32:29 UTC"
```
