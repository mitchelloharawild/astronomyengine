# Rotation Matrix from EQJ to ECL

Calculates a rotation matrix from J2000 mean equator (EQJ) to J2000 mean
ecliptic (ECL).

## Usage

``` r
astro_rotation_EQJ_ECL(time_posix)
```

## Arguments

- time_posix:

  A POSIXct object specifying the date and time at which the Earth's
  equator defines the target orientation.

## Value

A rotation matrix that converts EQJ to ECL at the specified time.

## Details

This is one of the family of functions that returns a rotation matrix
for converting from one orientation to another.

**Source**: EQJ = equatorial system, using equator at J2000 epoch.

**Target**: ECL = ecliptic system, using equator at J2000 epoch.

## Examples

``` r
time <- as.POSIXct("2024-01-01", tz = "UTC")
astro_rotation_EQJ_ECL(time)
#>             [,1]        [,2]          [,3]
#> [1,] 0.999983034 -0.00582517 -4.622477e-06
#> [2,] 0.005342560  0.91745103 -3.978129e-01
#> [3,] 0.002321568  0.39780608  9.174666e-01
```
