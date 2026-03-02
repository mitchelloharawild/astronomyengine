# Heliocentric ecliptic longitude of a body

Calculates the angle around the ecliptic plane of a celestial body as
seen from the center of the Sun. The angle is measured prograde (in the
direction of Earth's orbit) in degrees from the true equinox of date,
with values in the range \[0, 360).

## Usage

``` r
astro_ecliptic_longitude(body, time)
```

## Arguments

- body:

  Identifier of celestial body (e.g., `astro_body[["MARS"]]`). Must not
  be the Sun.

- time:

  A POSIXct time value.

## Value

A numeric value with the ecliptic longitude in degrees \[0, 360).

## Examples

``` r
time <- as.POSIXct("2025-02-19 22:10:12", tz = "UTC")
astro_ecliptic_longitude(astro_body[["MARS"]], time)
#> [1] 131.9139
```
