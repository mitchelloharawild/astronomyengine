# Search for maximum elongation

Finds the next date and time when Mercury or Venus reaches its maximum
angle from the Sun as seen from the Earth. Maximum elongation events are
the best opportunities for observing these inner planets.

## Usage

``` r
astro_search_max_elongation(body, start_time)
```

## Arguments

- body:

  Integer code for the celestial body. Must be Mercury (3) or Venus (2).
  Other values will fail.

- start_time:

  A POSIXct date-time value indicating the search start time. The
  maximum elongation event found will be the first one occurring after
  this time.

## Value

A list with the following elements:

- visibility:

  Integer flag indicating morning (0) or evening (1) visibility.

- elongation:

  The maximum elongation angle in degrees.

- ecliptic_separation:

  The ecliptic separation at maximum elongation.

- time:

  A POSIXct value representing the time of maximum elongation.

- status:

  Status code from the underlying C function.

## Examples

``` r
start <- as.POSIXct("2025-01-01 00:00:00", tz = "UTC")
astro_search_max_elongation(body = astro_body["MERCURY"], start_time = start)
#> $visibility
#> [1] 1
#> 
#> $elongation
#> [1] 18.24822
#> 
#> $ecliptic_separation
#> [1] 18.15419
#> 
#> $time
#> [1] "2025-03-08 06:05:33 UTC"
#> 
#> $status
#> [1] 0
#> 
```
