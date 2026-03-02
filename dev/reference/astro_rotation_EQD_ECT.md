# Rotation Matrix from EQD to ECT

Calculates a rotation matrix from equator of date (EQD) to true ecliptic
of date (ECT).

## Usage

``` r
astro_rotation_EQD_ECT(time)
```

## Arguments

- time:

  A POSIXct object representing the date and time of the
  equator/ecliptic conversion.

## Value

A rotation matrix that converts EQD to ECT.

## Details

This is one of the family of functions that returns a rotation matrix
for converting from one orientation to another.

**Source**: EQD = equator of date.

**Target**: ECT = true ecliptic of date.

## Examples

``` r
astro_rotation_EQD_ECT(Sys.time())
#>      [,1]      [,2]       [,3]
#> [1,]    1 0.0000000  0.0000000
#> [2,]    0 0.9174884 -0.3977625
#> [3,]    0 0.3977625  0.9174884
```
