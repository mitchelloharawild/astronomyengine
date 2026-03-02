# Moon Phase Angle

Returns the Moon's phase as an angle from 0 to 360 degrees, where 0 is
new moon, 90 is first quarter, 180 is full moon, and 270 is third
quarter.

## Usage

``` r
astro_moon_phase(time)
```

## Arguments

- time:

  A POSIXct datetime representing the observation time.

## Value

A numeric value representing the Moon's phase angle in degrees (0-360).

## Examples

``` r
astro_moon_phase(as.POSIXct("2025-02-19 12:00:00", tz = "UTC"))
#> [1] 256.4968
```
