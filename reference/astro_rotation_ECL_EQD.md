# Rotation Matrix from J2000 Ecliptic to Equatorial of-Date

Calculates a rotation matrix from J2000 mean ecliptic (ECL) to
equatorial of-date (EQD).

## Usage

``` r
astro_rotation_ECL_EQD(time)
```

## Arguments

- time:

  A POSIXct object representing the date and time.

## Value

A rotation matrix that converts ECL to EQD.

## Details

This is one of the family of functions that returns a rotation matrix
for converting from one orientation to another.

**Source**: ECL = ecliptic system, using equator at J2000 epoch.

**Target**: EQD = equatorial system, using equator of date.

## Examples

``` r
astro_rotation_ECL_EQD(Sys.time())
#>               [,1]         [,2]        [,3]
#> [1,]  9.999794e-01  0.005883043 0.002556375
#> [2,] -6.414454e-03  0.917445944 0.397808742
#> [3,] -5.010079e-06 -0.397816956 0.917464806
```
