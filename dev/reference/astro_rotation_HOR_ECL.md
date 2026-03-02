# Rotation Matrix from HOR to ECL

Calculates a rotation matrix from horizontal (HOR) to J2000 mean
ecliptic (ECL).

## Usage

``` r
astro_rotation_HOR_ECL(time, latitude, longitude, height)
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

A rotation matrix that converts HOR to ECL.

## Details

This is one of the family of functions that returns a rotation matrix
for converting from one orientation to another.

**Source**: HOR = horizontal system (x = north, y = west, z = zenith).

**Target**: ECL = ecliptic system, using equator at J2000 epoch.

## Examples

``` r
astro_rotation_HOR_ECL(Sys.time(), latitude = -35.28, longitude = 149.12, height = 0)
#>           [,1]       [,2]       [,3]
#> [1,] 0.4374155  0.6725530  0.5969424
#> [2,] 0.6571896 -0.6921853  0.2982974
#> [3,] 0.6138155  0.2618244 -0.7447674
```
