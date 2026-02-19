# Rotation Matrix from ECT to EQJ

Calculates a rotation matrix from true ecliptic of date (ECT) to J2000
mean equator (EQJ).

## Usage

``` r
astro_rotation_ECT_EQJ(time)
```

## Arguments

- time:

  A POSIXct object representing the date and time at which the Earth's
  ecliptic defines the source orientation.

## Value

A rotation matrix that converts ECT to EQJ.

## Details

This is one of the family of functions that returns a rotation matrix
for converting from one orientation to another.

**Source**: ECT = ecliptic system, using true equinox of the specified
date/time.

**Target**: EQJ = equatorial system, using mean equator at J2000 epoch.

## Examples

``` r
astro_rotation_ECT_EQJ(Sys.time())
#>              [,1]         [,2]         [,3]
#> [1,] 9.999795e-01 -0.005876185 -0.002553092
#> [2,] 6.406856e-03  0.917486911  0.397714370
#> [3,] 5.384859e-06 -0.397722565  0.917505728
```
