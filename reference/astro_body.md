# Celestial body codes

Integer codes used by Astronomy Engine to identify celestial bodies.
Pass these constants (or their integer values) to functions that accept
a `body` argument.

## Usage

``` r
astro_body
```

## Format

An integer vector with named elements:

- MERCURY:

  0

- VENUS:

  1

- EARTH:

  2

- MARS:

  3

- JUPITER:

  4

- SATURN:

  5

- URANUS:

  6

- NEPTUNE:

  7

- PLUTO:

  8

- SUN:

  9

- MOON:

  10

- EMB:

  11 — Earth/Moon Barycenter

- SSB:

  12 — Solar System Barycenter

## Examples

``` r
astro_body["SUN"]
#> SUN 
#>   9 
astro_body["MARS"]
#> MARS 
#>    3 
```
