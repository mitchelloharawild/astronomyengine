# Search for lunar apsis events

Finds the date and time of the Moon's closest distance (perigee) or
farthest distance (apogee) with respect to the Earth after a given start
time.

## Usage

``` r
search_lunar_apsis(start_time)
```

## Arguments

- start_time:

  A `POSIXct` datetime object indicating when to start the search.

## Value

A list containing:

- time:

  A `POSIXct` datetime of the next lunar apsis.

- kind:

  Integer code: 0 for perigee (APSIS_PERICENTER), 1 for apogee
  (APSIS_APOCENTER).

- dist_au:

  Distance in astronomical units.

- dist_km:

  Distance in kilometers.

## Details

The closest point is called *perigee* and the farthest point is called
*apogee*. The word *apsis* refers to either event.

To iterate through consecutive alternating perigee and apogee events,
call `search_lunar_apsis()` once, then use the return value to call
[`next_lunar_apsis()`](https://pkg.mitchelloharawild.com/astronomyengine/reference/next_lunar_apsis.md).
After that, keep feeding the previous return value from
[`next_lunar_apsis()`](https://pkg.mitchelloharawild.com/astronomyengine/reference/next_lunar_apsis.md)
into another call of
[`next_lunar_apsis()`](https://pkg.mitchelloharawild.com/astronomyengine/reference/next_lunar_apsis.md)
as many times as desired.

## Examples

``` r
start <- as.POSIXct("2025-01-01", tz = "UTC")
apsis <- search_lunar_apsis(start)
apsis$time
#> [1] "2025-01-07 23:58:50 UTC"
apsis$kind
#> [1] 0
```
