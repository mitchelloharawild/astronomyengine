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
#> [1,] -0.5018410  0.488628413 -0.7137212
#> [2,]  0.2822486  0.872491053  0.3988672
#> [3,]  0.8176132 -0.001278879 -0.5757665
```
