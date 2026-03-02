# Rotation Matrix from EQJ to EQD

Calculates a rotation matrix from J2000 mean equator (EQJ) to equatorial
of-date (EQD).

## Usage

``` r
astro_rotation_EQJ_EQD(time_posix)
```

## Arguments

- time_posix:

  A POSIXct object specifying the date and time at which the Earth's
  equator defines the target orientation.

## Value

A rotation matrix that converts EQJ to EQD at the specified time.

## Details

This is one of the family of functions that returns a rotation matrix
for converting from one orientation to another.

**Source**: EQJ = equatorial system, using equator at J2000 epoch.

**Target**: EQD = equatorial system, using equator of the specified
date/time.

## Examples

``` r
time <- as.POSIXct("2024-01-01", tz = "UTC")
astro_rotation_EQJ_EQD(time)
#>              [,1]          [,2]         [,3]
#> [1,]  0.999983034  5.342560e-03 2.321568e-03
#> [2,] -0.005342651  9.999857e-01 3.289619e-05
#> [3,] -0.002321360 -4.529896e-05 9.999973e-01
```
