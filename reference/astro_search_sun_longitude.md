# Search for Sun longitude

Searches for the time when the Sun reaches a specified apparent ecliptic
longitude as seen from the center of the Earth.

## Usage

``` r
astro_search_sun_longitude(target_lon, start_time, limit_days)
```

## Arguments

- target_lon:

  Numeric. The desired ecliptic longitude in degrees, relative to the
  true equinox of date. Must be in the range \[0, 360). Conventional
  values: 0 = March equinox, 90 = June solstice, 180 = September
  equinox, 270 = December solstice.

- start_time:

  POSIXct. The date and time for starting the search.

- limit_days:

  Numeric. The number of days to search forward from `start_time`.
  Recommended range: 1 to 10 days.

## Value

A list with element:

- time:

  POSIXct value indicating when the Sun reaches the target longitude.

## Details

This function can be used to determine equinoxes and solstices. However,
for calculating all equinoxes and solstices for a calendar year,
[`astro_seasons()`](https://pkg.mitchelloharawild.com/astronomyengine/reference/astro_seasons.md)
is usually more convenient and efficient.

The search is performed within the time window from `start_time` to
`start_time + limit_days`. It is recommended to keep the search window
smaller than 10 days when possible.

## Examples

``` r
# Find the March equinox in 2025
start <- as.POSIXct("2025-03-15", tz = "UTC")
astro_search_sun_longitude(0, start, 10)
#> [1] "2025-03-20 09:01:26 UTC"
```
