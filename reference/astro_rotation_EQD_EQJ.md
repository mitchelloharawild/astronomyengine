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
#> [1,] 0.999979476 -5.876191e-03 -0.0025530943
#> [2,] 0.005876081  9.999827e-01 -0.0000508048
#> [3,] 0.002553349  3.580157e-05  0.9999967396
```
