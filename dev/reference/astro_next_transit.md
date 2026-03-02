# Search for the next transit of Mercury or Venus

Finds the next transit of Mercury or Venus after a previous transit.
Call this repeatedly to find successive transits.

## Usage

``` r
astro_next_transit(body, prev_transit_time)
```

## Arguments

- body:

  Integer code for the planet. Use `1` for Mercury or `2` for Venus.

- prev_transit_time:

  A `POSIXct` datetime from a previous transit result.

## Value

A list with elements:

- start:

  Start time of the transit (POSIXct).

- peak:

  Time of closest approach (POSIXct).

- finish:

  End time of the transit (POSIXct).

- separation:

  Angular separation at peak in arcminutes.

## Examples

``` r
start <- as.POSIXct("2025-01-01", tz = "UTC")
transit1 <- astro_search_transit(astro_body["MERCURY"], start)
transit2 <- astro_next_transit(astro_body["MERCURY"], transit1$peak)
```
