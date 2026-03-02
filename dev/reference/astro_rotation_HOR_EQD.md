# Rotation Matrix from HOR to EQD

Calculates a rotation matrix from horizontal (HOR) to equatorial of-date
(EQD).

## Usage

``` r
astro_rotation_HOR_EQD(time, latitude, longitude, height)
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

A rotation matrix that converts HOR to EQD.

## Details

This is one of the family of functions that returns a rotation matrix
for converting from one orientation to another.

**Source**: HOR = horizontal system (x = north, y = west, z = zenith).

**Target**: EQD = equatorial system, using equator of the specified
date/time.

## Examples

``` r
astro_rotation_HOR_EQD(Sys.time(), latitude = -35.28, longitude = 149.12, height = 0)
#>           [,1]       [,2]       [,3]
#> [1,] 0.4295907  0.3860597  0.8163393
#> [2,] 0.6684175 -0.7437863  0.0000000
#> [3,] 0.6071819  0.5456554 -0.5775727
```
