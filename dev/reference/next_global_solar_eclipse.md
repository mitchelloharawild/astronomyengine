# Search for the next global solar eclipse

Finds the next solar eclipse in a series after the given eclipse time.
Typically, you pass the `peak` value from a previous
`search_global_solar_eclipse` or `next_global_solar_eclipse` call.

## Usage

``` r
next_global_solar_eclipse(prev_eclipse_time)
```

## Arguments

- prev_eclipse_time:

  A `POSIXct` time near a previous eclipse peak.

## Value

A list with the same structure as `search_global_solar_eclipse`.

## Examples

``` r
start <- as.POSIXct("2025-01-01", tz = "UTC")
eclipse1 <- search_global_solar_eclipse(start)
eclipse2 <- next_global_solar_eclipse(eclipse1$peak)
```
