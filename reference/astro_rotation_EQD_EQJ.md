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
#>             [,1]          [,2]          [,3]
#> [1,] 0.999979467 -5.877498e-03 -2.553663e-03
#> [2,] 0.005877388  9.999827e-01 -5.046566e-05
#> [3,] 0.002553915  3.545575e-05  9.999967e-01
```
