# Get the name of a celestial body

Finds the name of a celestial body.

## Usage

``` r
astro_body_name(body)
```

## Arguments

- body:

  The celestial body whose name is to be found.

## Value

The English-language name of the celestial body, or `""` if the body is
not valid.

## Examples

``` r
astro_body_name(astro_body["SUN"])
#> [1] "Sun"
astro_body_name(9L)
#> [1] "Sun"
```
