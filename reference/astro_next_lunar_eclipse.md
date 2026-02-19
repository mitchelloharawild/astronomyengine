# Find the next lunar eclipse in a series

After using
[`astro_search_lunar_eclipse()`](https://pkg.mitchelloharawild.com/astronomyengine/reference/astro_search_lunar_eclipse.md)
to find the first lunar eclipse, call this function to find the next
consecutive lunar eclipse. Pass in the `peak` value from the previous
call.

## Usage

``` r
astro_next_lunar_eclipse(prev_eclipse_time)
```

## Arguments

- prev_eclipse_time:

  A `POSIXct` time near a lunar eclipse peak (typically from a previous
  call).

## Value

A list with the following elements:

- kind:

  Integer code for eclipse type (0=penumbral, 1=partial, 2=total).

- obscuration:

  Fraction of Moon's disc covered by Earth's umbra (0-1).

- peak:

  POSIXct time of eclipse peak.

- sd_total:

  Semi-duration of total phase in minutes.

- sd_partial:

  Semi-duration of partial phase in minutes.

- sd_penum:

  Semi-duration of penumbral phase in minutes.

## Examples

``` r
start <- as.POSIXct("2025-01-01", tz = "UTC")
first_eclipse <- astro_search_lunar_eclipse(start)
next_eclipse <- astro_next_lunar_eclipse(first_eclipse$peak)
```
