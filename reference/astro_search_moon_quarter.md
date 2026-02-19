# Find First Lunar Quarter

Finds the first lunar quarter (new moon, first quarter, full moon, or
third quarter) after the specified date and time.

## Usage

``` r
astro_search_moon_quarter(start_time)
```

## Arguments

- start_time:

  A POSIXct datetime to begin the search.

## Value

A list with:

- quarter:

  Integer 0-3: 0 = new moon, 1 = first quarter, 2 = full moon, 3 = third
  quarter.

- time:

  POSIXct datetime of the lunar quarter.

## Examples

``` r
start <- as.POSIXct("2025-02-19", tz = "UTC")
astro_search_moon_quarter(start)
#> $quarter
#> [1] 3
#> 
#> $time
#> [1] "2025-02-20 17:33:11 UTC"
#> 
```
