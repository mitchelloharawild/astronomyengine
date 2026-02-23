# Rotation Matrix from ECT to EQD

Calculates a rotation matrix from true ecliptic of date (ECT) to equator
of date (EQD).

## Usage

``` r
astro_rotation_ECT_EQD(time)
```

## Arguments

- time:

  A POSIXct object representing the date and time of the
  ecliptic/equator conversion.

## Value

A rotation matrix that converts ECT to EQD.

## Details

This is one of the family of functions that returns a rotation matrix
for converting from one orientation to another.

**Source**: ECT = true ecliptic of date.

**Target**: EQD = equator of date.

## Examples

``` r
astro_rotation_ECT_EQD(Sys.time())
#>      [,1]       [,2]      [,3]
#> [1,]    1  0.0000000 0.0000000
#> [2,]    0  0.9174887 0.3977619
#> [3,]    0 -0.3977619 0.9174887
```
