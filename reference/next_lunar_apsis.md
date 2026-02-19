# Find the next lunar apsis event

Given a lunar apsis event (perigee or apogee), finds the next apsis
event in the series. This function alternates between finding perigees
and apogees.

## Usage

``` r
next_lunar_apsis(apsis)
```

## Arguments

- apsis:

  A list returned from
  [`search_lunar_apsis()`](https://pkg.mitchelloharawild.com/astronomyengine/reference/search_lunar_apsis.md)
  or a previous call to `next_lunar_apsis()`.

## Value

A list with the same structure as
[`search_lunar_apsis()`](https://pkg.mitchelloharawild.com/astronomyengine/reference/search_lunar_apsis.md):

- time:

  A `POSIXct` datetime of the next lunar apsis.

- kind:

  Integer code: 0 for perigee, 1 for apogee.

- dist_au:

  Distance in astronomical units.

- dist_km:

  Distance in kilometers.

## Examples

``` r
start <- as.POSIXct("2025-01-01", tz = "UTC")
apsis1 <- search_lunar_apsis(start)
apsis2 <- next_lunar_apsis(apsis1)
apsis3 <- next_lunar_apsis(apsis2)
```
