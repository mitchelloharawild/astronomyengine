# Search for the next rise or set time of a celestial body

Searches for the next time a celestial body rises or sets as seen by an
observer on the Earth. Rise time is when the body first starts to be
visible above the horizon. Set time is when the body appears to vanish
below the horizon. This function adjusts for the apparent angular radius
of the observed body (significant only for the Sun and Moon) and
corrects for atmospheric refraction.

## Usage

``` r
astro_search_rise_set(
  body,
  time,
  latitude,
  longitude,
  height = 0,
  direction = 1L,
  limit_days = 1,
  meters_above_ground = 0
)
```

## Arguments

- body:

  Integer body code (see
  [astro_body](https://pkg.mitchelloharawild.com/astronomyengine/reference/astro_body.md)).

- time:

  A `POSIXct` date/time in UTC to start the search from.

- latitude:

  Observer's geographic latitude in degrees.

- longitude:

  Observer's geographic longitude in degrees.

- height:

  Observer's height above sea level in metres. Default `0`.

- direction:

  `1L` to find the next rise, `-1L` to find the next set. Default `1L`
  (rise).

- limit_days:

  Maximum number of days to search. When positive, searches forward in
  time; when negative, searches backward. Default `1`.

- meters_above_ground:

  Height of observer above the ground (not sea level) in metres, for
  computing the dip of the horizon. Default `0`.

## Value

A `POSIXct` value in UTC, or `NA` if no event is found within
`limit_days`.

## Details

Rise or set may not occur in every 24-hour period. For example, near the
Earth's poles, there are long periods where the Sun stays below the
horizon, never rising.

## Examples

``` r
t <- as.POSIXct("2025-06-21", tz = "UTC")
# Find next sunrise at Sydney Observatory
astro_search_rise_set(astro_body[["SUN"]], t,
                      latitude = -33.8688, longitude = 151.2093)
#> [1] "2025-06-21 21:00:14 UTC"
```
