# Rotation Matrix from Equatorial of-Date to J2000 Ecliptic

Calculates a rotation matrix from equatorial of-date (EQD) to J2000 mean
ecliptic (ECL).

## Usage

``` r
astro_rotation_EQD_ECL(time)
```

## Arguments

- time:

  A POSIXct object representing the date and time.

## Value

A rotation matrix that converts EQD to ECL.

## Details

This is one of the family of functions that returns a rotation matrix
for converting from one orientation to another.

**Source**: EQD = equatorial system, using equator of date.

**Target**: ECL = ecliptic system, using equator at J2000 epoch.

## Examples

``` r
astro_rotation_EQD_ECL(Sys.time())
#>             [,1]         [,2]          [,3]
#> [1,] 0.999979427 -0.006414454 -5.010079e-06
#> [2,] 0.005883043  0.917445944 -3.978170e-01
#> [3,] 0.002556375  0.397808742  9.174648e-01
```
