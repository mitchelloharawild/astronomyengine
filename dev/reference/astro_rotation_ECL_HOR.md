# Rotation Matrix from ECL to HOR

Calculates a rotation matrix from J2000 mean ecliptic (ECL) to
horizontal (HOR).

## Usage

``` r
astro_rotation_ECL_HOR(time, latitude, longitude, height)
```

## Arguments

- time:

  A POSIXct object representing the date and time of observation.

- latitude:

  The observer's geographic latitude in degrees.

- longitude:

  The observer's geographic longitude in degrees.

- height:

  The observer's elevation above sea level in meters.

## Value

A rotation matrix that converts ECL to HOR. The components of the
horizontal vector are: x = north, y = west, z = zenith (straight up from
the observer).

## Details

This is one of the family of functions that returns a rotation matrix
for converting from one orientation to another.

**Source**: ECL = ecliptic system, using equator at J2000 epoch.

**Target**: HOR = horizontal system (x = north, y = west, z = zenith).

## Examples

``` r
astro_rotation_ECL_HOR(Sys.time(), latitude = -35.28, longitude = 149.12, height = 0)
#>           [,1]       [,2]       [,3]
#> [1,] 0.4339869  0.6639364  0.6089695
#> [2,] 0.6761316 -0.6867458  0.2668824
#> [3,] 0.5954002  0.2959200 -0.7469470
```
