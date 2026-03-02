# Rotation Matrix from EQJ to ECT

Calculates a rotation matrix from J2000 mean equator (EQJ) to true
ecliptic of date (ECT).

## Usage

``` r
astro_rotation_EQJ_ECT(time_posix)
```

## Arguments

- time_posix:

  A POSIXct object specifying the date and time at which the Earth's
  equator defines the target orientation.

## Value

A rotation matrix that converts EQJ to ECT at the specified time.

## Details

This is one of the family of functions that returns a rotation matrix
for converting from one orientation to another.

**Source**: EQJ = equatorial system, using mean equator at J2000 epoch.

**Target**: ECT = ecliptic system, using true equinox of the specified
date/time.

## Examples

``` r
time <- as.POSIXct("2024-01-01", tz = "UTC")
astro_rotation_EQJ_ECT(time)
#>              [,1]       [,2]          [,3]
#> [1,]  0.999983034 0.00582517  4.939740e-06
#> [2,] -0.005342651 0.91748825 -3.977270e-01
#> [3,] -0.002321360 0.39772024  9.175038e-01
```
