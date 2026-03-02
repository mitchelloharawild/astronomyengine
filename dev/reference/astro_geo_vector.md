# Geocentric position vector of a celestial body

Calculates the position of a celestial body as a vector using the center
of the Earth as the origin. The result is expressed as a Cartesian
vector in the J2000 equatorial system (the mean equator of the Earth at
noon UTC on 1 January 2000).

## Usage

``` r
astro_geo_vector(body, time, aberration = "ABERRATION")
```

## Arguments

- body:

  Identifier of celestial body (e.g., `astro_body["MERCURY"]`).

- time:

  A POSIXct time value.

- aberration:

  One of `"ABERRATION"` or `"NO_ABERRATION"`. Default is `"ABERRATION"`.

## Value

A list with elements:

- x:

  X coordinate in AU.

- y:

  Y coordinate in AU.

- z:

  Z coordinate in AU.

- time:

  Observation time as POSIXct.

## Details

This function corrects for light travel time. The position of the body
is back-dated by the amount of time it takes light to travel from that
body to an observer on Earth.

The position can optionally be corrected for aberration, an effect
causing the apparent direction of the body to be shifted due to
transverse movement of the Earth.

## Examples

``` r
time <- as.POSIXct("2025-02-19 22:10:12", tz = "UTC")
astro_geo_vector(astro_body["MARS"], time)
#> $x
#> [1] -0.2282868
#> 
#> $y
#> [1] 0.6741606
#> 
#> $z
#> [1] 0.3497665
#> 
#> $time
#> [1] "2025-02-19 22:10:12 UTC"
#> 
```
