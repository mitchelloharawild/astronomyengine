# Search for a global solar eclipse

Searches for the first solar eclipse visible anywhere on Earth's surface
that occurs after the given start time. A solar eclipse may be partial,
annular, or total. To find a series of eclipses, use
`next_global_solar_eclipse` with the `peak` time from the previous
result.

## Usage

``` r
search_global_solar_eclipse(start_time)
```

## Arguments

- start_time:

  A `POSIXct` date/time for starting the search.

## Value

A list containing:

- status:

  Status code (0 = success).

- kind:

  Type of eclipse: 0 = partial, 1 = annular, 2 = total.

- peak:

  Peak time of the eclipse as `POSIXct`.

- distance:

  Distance in kilometers from Earth's center to Moon's shadow axis.

- latitude:

  Latitude of peak eclipse.

- longitude:

  Longitude of peak eclipse.

## Examples

``` r
start <- as.POSIXct("2025-01-01", tz = "UTC")
search_global_solar_eclipse(start)
#> $status
#> [1] 0
#> 
#> $kind
#> [1] 2
#> 
#> $peak
#> [1] "2025-03-29 10:47:25 UTC"
#> 
#> $distance
#> [1] 6637.035
#> 
#> $latitude
#> [1] NaN
#> 
#> $longitude
#> [1] NaN
#> 
```
