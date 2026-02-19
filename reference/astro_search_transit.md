# Search for a transit of Mercury or Venus

Finds the first transit of Mercury or Venus after a specified date. A
transit occurs when an inferior planet passes between the Sun and Earth,
with the planet's silhouette visible against the Sun.

## Usage

``` r
astro_search_transit(body, start_time)
```

## Arguments

- body:

  Integer code for the planet. Use `1` for Mercury or `2` for Venus.

- start_time:

  A `POSIXct` datetime for starting the search.

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
astro_search_transit(astro_body["MERCURY"], start)
#> $start
#> [1] "2032-11-13 06:41:48 UTC"
#> 
#> $peak
#> [1] "2032-11-13 08:54:14 UTC"
#> 
#> $finish
#> [1] "2032-11-13 11:06:53 UTC"
#> 
#> $separation
#> [1] 9.594123
#> 
```
