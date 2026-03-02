# Search for a Specific Moon Phase

Searches for the time when the Moon reaches a specified phase angle.

## Usage

``` r
astro_search_moon_phase(target_lon, start_time, limit_days)
```

## Arguments

- target_lon:

  A numeric value in the range \[0, 360) representing the target phase
  angle. Common values: 0 = new moon, 90 = first quarter, 180 = full
  moon, 270 = third quarter.

- start_time:

  A POSIXct datetime to begin the search.

- limit_days:

  A numeric value specifying the search window in days. Positive values
  search forward, negative values search backward.

## Value

A POSIXct datetime when the Moon reaches the target phase.

## Examples

``` r
start <- as.POSIXct("2025-02-19", tz = "UTC")
astro_search_moon_phase(0, start, 30)  # Find next new moon
#> [1] "2025-02-28 00:45:22 UTC"
```
