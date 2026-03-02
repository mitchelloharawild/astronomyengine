# Search for a lunar eclipse

Searches for the first lunar eclipse that occurs after the given start
time. A lunar eclipse may be penumbral, partial, or total.

## Usage

``` r
astro_search_lunar_eclipse(start_time)
```

## Arguments

- start_time:

  A `POSIXct` date and time for starting the search.

## Value

A list with the following elements:

- kind:

  Integer code for eclipse type (0=penumbral, 1=partial, 2=total).

- obscuration:

  Fraction of Moon's disc covered by Earth's umbra (0-1).

- peak:

  POSIXct time of eclipse peak.

- sd_total:

  Semi-duration of total phase in minutes.

- sd_partial:

  Semi-duration of partial phase in minutes.

- sd_penum:

  Semi-duration of penumbral phase in minutes.

## Examples

``` r
start <- as.POSIXct("2025-01-01", tz = "UTC")
astro_search_lunar_eclipse(start)
#> $kind
#> [1] 4
#> 
#> $obscuration
#> [1] 1
#> 
#> $peak
#> [1] "2025-03-14 06:58:42 UTC"
#> 
#> $sd_total
#> [1] 33.25397
#> 
#> $sd_partial
#> [1] 109.4825
#> 
#> $sd_penum
#> [1] 181.6559
#> 
```
