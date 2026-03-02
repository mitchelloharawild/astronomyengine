# Rotation Matrix from EQJ to GAL

Calculates a rotation matrix from J2000 mean equator (EQJ) to galactic
(GAL).

## Usage

``` r
astro_rotation_EQJ_GAL()
```

## Value

A rotation matrix that converts EQJ to GAL.

## Details

This is one of the family of functions that returns a rotation matrix
for converting from one orientation to another.

**Source**: EQJ = equatorial system, using the equator at the J2000
epoch.

**Target**: GAL = galactic system (IAU 1958 definition).

## Examples

``` r
astro_rotation_EQJ_GAL()
#>             [,1]       [,2]       [,3]
#> [1,] -0.05486248  0.4941096 -0.8676669
#> [2,] -0.87345728 -0.4447938 -0.1980678
#> [3,] -0.48380005  0.7470035  0.4559861
```
