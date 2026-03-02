# Search for the next local solar eclipse

Finds the next solar eclipse in a series at a specific location.
Typically, you pass the `peak` value from a previous
`search_local_solar_eclipse` or `next_local_solar_eclipse` call.

## Usage

``` r
next_local_solar_eclipse(prev_eclipse_time, latitude, longitude)
```

## Arguments

- prev_eclipse_time:

  A `POSIXct` time near a previous eclipse peak.

- latitude:

  Latitude of the observer in degrees (-90 to 90).

- longitude:

  Longitude of the observer in degrees (-180 to 180).

## Value

A list with the same structure as `search_local_solar_eclipse`.

## Examples

``` r
start <- as.POSIXct("2025-01-01", tz = "UTC")
eclipse1 <- search_local_solar_eclipse(start, 37.77, -122.41)
eclipse2 <- next_local_solar_eclipse(eclipse1$peak$time, 37.77, -122.41)
```
