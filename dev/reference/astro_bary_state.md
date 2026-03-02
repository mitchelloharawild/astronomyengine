# Barycentric position and velocity vectors

Calculates the barycentric (solar system barycenter) position and
velocity vectors for a given celestial body at a specified time.

## Usage

``` r
astro_bary_state(body, time)
```

## Arguments

- body:

  Identifier of celestial body (e.g., `astro_body["MERCURY"]`).

- time:

  A POSIXct time value.

## Value

A list with elements:

- x:

  X position in AU.

- y:

  Y position in AU.

- z:

  Z position in AU.

- vx:

  X velocity in AU/day.

- vy:

  Y velocity in AU/day.

- vz:

  Z velocity in AU/day.

- time:

  Observation time as POSIXct.

## Details

The vectors are expressed in J2000 mean equator coordinates (the mean
equator of the Earth at noon UTC on 1 January 2000).

## Examples

``` r
time <- as.POSIXct("2025-02-19 22:10:12", tz = "UTC")
astro_bary_state(astro_body["MARS"], time)
#> $x
#> [1] -1.099886
#> 
#> $y
#> [1] 1.106853
#> 
#> $z
#> [1] 0.5375253
#> 
#> $vx
#> [1] -0.009936038
#> 
#> $vy
#> [1] -0.00745567
#> 
#> $vz
#> [1] -0.003151791
#> 
#> $time
#> [1] "2025-02-19 22:10:12 UTC"
#> 
```
