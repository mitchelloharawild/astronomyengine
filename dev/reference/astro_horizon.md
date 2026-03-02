# Horizontal coordinates of a celestial body

Calculates the apparent location of a body relative to the local horizon
of an observer on Earth.

## Usage

``` r
astro_horizon(
  time,
  latitude,
  longitude,
  ra,
  dec,
  refraction = "REFRACTION_NORMAL"
)
```

## Arguments

- time:

  A POSIXct time value.

- latitude:

  Observer's geographic latitude in degrees (positive north).

- longitude:

  Observer's geographic longitude in degrees (positive east).

- ra:

  Right ascension of the body in sidereal hours.

- dec:

  Declination of the body in degrees.

- refraction:

  One of `"REFRACTION_NORMAL"`, `"REFRACTION_JPLHOR"`, or
  `"REFRACTION_NONE"`.

## Value

A list with elements:

- azimuth:

  Azimuth angle in degrees (eastward from north).

- altitude:

  Altitude angle in degrees (positive above horizon).

- ra:

  Right ascension of the body in sidereal hours.

- dec:

  Declination of the body in degrees.

## Details

Given a date, time, geographic location, and equatorial coordinates of a
celestial body, this function returns horizontal coordinates (azimuth
and altitude) relative to the horizon.

The `ra` and `dec` must be equator-of-date coordinates. Equator-of-date
coordinates can be obtained by calling
[`astro_equator()`](https://pkg.mitchelloharawild.com/astronomyengine/dev/reference/astro_equator.md)
with `equdate = "EQUATOR_OF_DATE"` and `aberration = "ABERRATION"`.

Atmospheric refraction correction is recommended. Pass
`refraction = "REFRACTION_NORMAL"` to correct for optical lensing of the
Earth's atmosphere that causes objects to appear higher above the
horizon than they actually are.

## Examples

``` r
time <- as.POSIXct("2025-02-19 22:10:12", tz = "UTC")
astro_horizon(time, latitude = -33.87, longitude = 151.21, ra = 10.5, dec = -20.0)
#> $azimuth
#> [1] 238.4689
#> 
#> $altitude
#> [1] -8.969315
#> 
#> $ra
#> [1] 10.5
#> 
#> $dec
#> [1] -20
#> 
```
