# Find Next Lunar Quarter

Continues searching for lunar quarters from a previous search result.
Call this function repeatedly after
[`astro_search_moon_quarter()`](https://pkg.mitchelloharawild.com/astronomyengine/reference/astro_search_moon_quarter.md)
to find consecutive lunar quarters.

## Usage

``` r
astro_next_moon_quarter(mq)
```

## Arguments

- mq:

  A list returned by
  [`astro_search_moon_quarter()`](https://pkg.mitchelloharawild.com/astronomyengine/reference/astro_search_moon_quarter.md)
  or a previous call to `astro_next_moon_quarter()`.

## Value

A list with:

- quarter:

  Integer 0-3: 0 = new moon, 1 = first quarter, 2 = full moon, 3 = third
  quarter.

- time:

  POSIXct datetime of the next lunar quarter.

## Examples

``` r
start <- as.POSIXct("2025-02-19", tz = "UTC")
q1 <- astro_search_moon_quarter(start)
q2 <- astro_next_moon_quarter(q1)
q3 <- astro_next_moon_quarter(q2)
```
