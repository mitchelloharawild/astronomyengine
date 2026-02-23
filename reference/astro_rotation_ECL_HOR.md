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
#> [1,] -0.2203049  0.9228955 -0.3158000
#> [2,]  0.8140205  0.3523273  0.4617750
#> [3,]  0.5374351 -0.1553364 -0.8288752
```
