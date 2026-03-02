# Rotation Matrix from GAL to EQJ

Calculates a rotation matrix from galactic (GAL) to J2000 mean equator
(EQJ).

## Usage

``` r
astro_rotation_GAL_EQJ()
```

## Value

A rotation matrix that converts GAL to EQJ.

## Details

This is one of the family of functions that returns a rotation matrix
for converting from one orientation to another.

**Source**: GAL = galactic system (IAU 1958 definition).

**Target**: EQJ = equatorial system, using the equator at the J2000
epoch.

## Examples

``` r
astro_rotation_GAL_EQJ()
#>             [,1]       [,2]       [,3]
#> [1,] -0.05486248 -0.8734573 -0.4838001
#> [2,]  0.49410959 -0.4447938  0.7470035
#> [3,] -0.86766688 -0.1980678  0.4559861
```
