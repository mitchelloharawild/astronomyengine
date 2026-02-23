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
#> [1,] -0.2345801 0.5268872  0.816922332
#> [2,]  0.9121907 0.4097591 -0.002344194
#> [3,] -0.3359765 0.7446391 -0.576742931
```
