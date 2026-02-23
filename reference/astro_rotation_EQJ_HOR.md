# Rotation Matrix from J2000 Equatorial to Horizontal

Calculates a rotation matrix from J2000 mean equator (EQJ) to horizontal
(HOR).

## Usage

``` r
astro_rotation_EQJ_HOR(time, latitude, longitude, height)
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

A rotation matrix that converts EQJ to HOR. The components represent: x
= north, y = west, z = zenith (straight up from observer).

## Details

This is one of the family of functions that returns a rotation matrix
for converting from one orientation to another.

**Source**: EQJ = equatorial system, using the equator at J2000 epoch.

**Target**: HOR = horizontal system (x=North, y=West, z=Zenith).

## Examples

``` r
astro_rotation_EQJ_HOR(Sys.time(), latitude = -35.28, longitude = 149.12, height = 0)
#>            [,1]         [,2]       [,3]
#> [1,] -0.2203548  0.922859474 -0.3158705
#> [2,]  0.5330491  0.385129551  0.7533484
#> [3,]  0.8168858 -0.002370567 -0.5767946
```
