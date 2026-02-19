# Topocentric equatorial coordinates of a celestial body

Calculates equatorial coordinates of a celestial body as seen by an
observer on Earth's surface.

## Usage

``` r
astro_equator(
  body,
  time,
  latitude,
  longitude,
  height = 0,
  equdate = FALSE,
  aberration = TRUE
)
```

## Arguments

- body:

  Identifier of celestial body (e.g., `astro_body[["SUN"]]`,
  `astro_body[["MARS"]]`). Must not be the Earth.

- time:

  A POSIXct time value.

- latitude:

  Observer's geographic latitude in degrees (positive north).

- longitude:

  Observer's geographic longitude in degrees (positive east).

- height:

  Observer's height in meters above sea level.

- equdate:

  One of `TRUE` (true-equator-of-date) or `FALSE` (J2000). Default is
  `FALSE`.

- aberration:

  One of `TRUE` (correct for aberration) or `FALSE`. Default is `TRUE`.

## Value

A list with elements:

- ra:

  Right ascension in sidereal hours.

- dec:

  Declination in degrees.

- dist:

  Distance in AU.

## Details

This function corrects for light travel time and topocentric parallax
(the angular shift depending on the observer's location on Earth).
Parallax correction is most significant for the Moon but has a small
effect on other bodies.

## Examples

``` r
time <- as.POSIXct("2025-02-19 22:10:12", tz = "UTC")
astro_equator(astro_body[["MARS"]], time, latitude = -33.87, longitude = 151.21)
#> $ra
#> [1] 7.247414
#> 
#> $dec
#> [1] 26.17006
#> 
#> $dist
#> [1] 0.7930461
#> 
```
