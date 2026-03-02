# Get the integer code for a celestial body by name

Returns the integer code corresponding to the given English name.

## Usage

``` r
astro_body_code(name)
```

## Arguments

- name:

  One of the following strings: Sun, Moon, Mercury, Venus, Earth, Mars,
  Jupiter, Saturn, Uranus, Neptune, Pluto, EMB, SSB.

## Value

If `name` is one of the listed strings (case-sensitive), the returned
value is the corresponding integer code (see
[astro_body](https://pkg.mitchelloharawild.com/astronomyengine/dev/reference/astro_body.md)),
otherwise it is `-1`.

## Examples

``` r
astro_body_code("Sun")
#> [1] 9
astro_body_code("Neptune")
#> [1] 7
```
