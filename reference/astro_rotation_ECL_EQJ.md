# Rotation Matrix from ECL to EQJ

Calculates a rotation matrix from J2000 mean ecliptic (ECL) to J2000
mean equator (EQJ).

## Usage

``` r
astro_rotation_ECL_EQJ()
```

## Value

A rotation matrix that converts ECL to EQJ.

## Details

This is one of the family of functions that returns a rotation matrix
for converting from one orientation to another.

**Source**: ECL = ecliptic system, using equator at J2000 epoch.

**Target**: EQJ = equatorial system, using equator at J2000 epoch.

## Examples

``` r
astro_rotation_ECL_EQJ()
#>      [,1]       [,2]      [,3]
#> [1,]    1  0.0000000 0.0000000
#> [2,]    0  0.9174821 0.3977770
#> [3,]    0 -0.3977770 0.9174821
```
