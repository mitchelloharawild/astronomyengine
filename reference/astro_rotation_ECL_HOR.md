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
#>            [,1]       [,2]       [,3]
#> [1,] -0.3940149  0.7277857 -0.5613201
#> [2,]  0.7108072  0.6284622  0.3158932
#> [3,]  0.5826710 -0.2745237 -0.7649387
```
