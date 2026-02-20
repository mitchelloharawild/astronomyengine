# Rotation Matrix from EQD to HOR

Calculates a rotation matrix from equatorial of-date (EQD) to horizontal
(HOR).

## Usage

``` r
astro_rotation_EQD_HOR(time, latitude, longitude, height)
```

## Arguments

- time:

  A POSIXct object representing the date and time at which the Earth's
  equator applies.

- latitude:

  The observer's geographic latitude in degrees.

- longitude:

  The observer's geographic longitude in degrees.

- height:

  The observer's elevation above sea level in meters.

## Value

A rotation matrix that converts EQD to HOR. The components of the
horizontal vector are: x = north, y = west, z = zenith (straight up from
the observer).

## Details

This is one of the family of functions that returns a rotation matrix
for converting from one orientation to another.

**Source**: EQD = equatorial system, using equator of the specified
date/time.

**Target**: HOR = horizontal system (x = north, y = west, z = zenith).

## Examples

``` r
astro_rotation_EQD_HOR(Sys.time(), latitude = -35.28, longitude = 149.12, height = 0)
#>            [,1]       [,2]       [,3]
#> [1,]  0.4805109 -0.5548524  0.6791525
#> [2,] -0.3204676 -0.8319488 -0.4529478
#> [3,]  0.8163393  0.0000000 -0.5775727
```
