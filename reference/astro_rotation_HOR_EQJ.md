# Rotation Matrix from Horizontal to J2000 Equatorial

Calculates a rotation matrix from horizontal (HOR) to J2000 mean equator
(EQJ).

## Usage

``` r
astro_rotation_HOR_EQJ(time, latitude, longitude, height)
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

A rotation matrix that converts HOR to EQJ at `time` and for the
observer.

## Details

This is one of the family of functions that returns a rotation matrix
for converting from one orientation to another.

**Source**: HOR = horizontal system (x=North, y=West, z=Zenith).

**Target**: EQJ = equatorial system, using equator at J2000 epoch.

## Examples

``` r
astro_rotation_HOR_EQJ(Sys.time(), latitude = -35.28, longitude = 149.12, height = 0)
#>            [,1]      [,2]         [,3]
#> [1,] -0.2048302 0.5392656  0.816845913
#> [2,]  0.9336224 0.3582505 -0.002397101
#> [3,] -0.2939281 0.7621347 -0.576850941
```
