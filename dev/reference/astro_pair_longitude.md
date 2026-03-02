# Ecliptic longitude of one body relative to another

Determines where one body appears around the ecliptic plane as seen from
Earth, relative to another body's apparent position.

## Usage

``` r
astro_pair_longitude(body1, body2, time)
```

## Arguments

- body1:

  First body (e.g., `astro_body["SUN"]`).

- body2:

  Second body (e.g., `astro_body["MOON"]`)

- time:

  A POSIXct time value.

## Value

A list with element:

- angle:

  Ecliptic longitude difference in degrees \[0, 360).

## Details

The returned angle is in the range \[0, 360) degrees. The angle is 0
when the two bodies are at the same ecliptic longitude. The angle
increases in the prograde direction (the direction planets orbit the
Sun). When the angle is 180 degrees, the bodies appear on opposite sides
of the sky.

Neither `body1` nor `body2` may be the Earth.

## Examples

``` r
time <- as.POSIXct("2025-02-19 22:10:12", tz = "UTC")
astro_pair_longitude(astro_body["SUN"], astro_body["MOON"], time)
#> $angle
#> [1] 98.88367
#> 
```
