# Rotation Matrix from EQD to EQJ

Calculates a rotation matrix from equatorial of-date (EQD) to J2000 mean
equator (EQJ).

## Usage

``` r
astro_rotation_EQD_EQJ(time)
```

## Arguments

- time:

  A POSIXct object representing the date and time at which the Earth's
  equator defines the source orientation.

## Value

A rotation matrix that converts EQD to EQJ.

## Details

This is one of the family of functions that returns a rotation matrix
for converting from one orientation to another.

**Source**: EQD = equatorial system, using equator of the specified
date/time.

**Target**: EQJ = equatorial system, using mean equator at J2000 epoch.

## Examples

``` r
astro_rotation_EQD_EQJ(Sys.time())
#>             [,1]         [,2]          [,3]
#> [1,] 0.999979467 -0.005877497 -0.0025536624
#> [2,] 0.005877387  0.999982727 -0.0000504659
#> [3,] 0.002553915  0.000035456  0.9999967381
```
