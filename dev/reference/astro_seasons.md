# Equinoxes and Solstices for a Given Year

Calculates the dates and times of both equinoxes and both solstices for
a given calendar year.

## Usage

``` r
astro_seasons(year)
```

## Arguments

- year:

  Integer calendar year. While any integer is accepted, only the years
  1800 through 2100 have been validated for accuracy. Unit testing
  against data from the United States Naval Observatory confirms that
  all equinoxes and solstices for this range are within 2 minutes of the
  correct time.

## Value

A list of `POSIXct` values (in UTC):

- mar_equinox:

  March equinox.

- jun_solstice:

  June solstice.

- sep_equinox:

  September equinox.

- dec_solstice:

  December solstice.

## Details

The equinoxes are the moments twice each year when the plane of the
Earth's equator passes through the center of the Sun. In other words,
the Sun's declination is zero at both equinoxes. The March equinox
defines the beginning of spring in the northern hemisphere and the
beginning of autumn in the southern hemisphere. The September equinox
defines the beginning of autumn in the northern hemisphere and the
beginning of spring in the southern hemisphere.

The solstices are the moments twice each year when one of the Earth's
poles is most tilted toward the Sun. More precisely, the Sun's
declination reaches its minimum value at the December solstice, which
defines the beginning of winter in the northern hemisphere and the
beginning of summer in the southern hemisphere. The Sun's declination
reaches its maximum value at the June solstice, which defines the
beginning of summer in the northern hemisphere and the beginning of
winter in the southern hemisphere.

## Examples

``` r
astro_seasons(2025)
#> $mar_equinox
#> [1] "2025-03-20 09:01:26 UTC"
#> 
#> $jun_solstice
#> [1] "2025-06-21 02:42:17 UTC"
#> 
#> $sep_equinox
#> [1] "2025-09-22 18:19:34 UTC"
#> 
#> $dec_solstice
#> [1] "2025-12-21 15:03:03 UTC"
#> 
```
