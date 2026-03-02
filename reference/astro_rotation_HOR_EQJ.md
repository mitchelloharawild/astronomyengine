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
#>           [,1]       [,2]         [,3]
#> [1,] 0.4407755  0.3757171  0.815201584
#> [2,] 0.6504574 -0.7595410 -0.001635439
#> [3,] 0.6185645  0.5309748 -0.579175020
```
