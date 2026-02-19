# Search for a local solar eclipse

Searches for the first solar eclipse visible at a specific location on
Earth's surface that occurs after the given start time. Note: an eclipse
reported by this function might be partly or completely invisible due to
the time of day. To find a series of eclipses, use
`next_local_solar_eclipse` with the `peak` time from the previous
result.

## Usage

``` r
search_local_solar_eclipse(start_time, latitude, longitude)
```

## Arguments

- start_time:

  A `POSIXct` date/time for starting the search.

- latitude:

  Latitude of the observer in degrees (-90 to 90).

- longitude:

  Longitude of the observer in degrees (-180 to 180).

## Value

A list containing:

- status:

  Status code (0 = success).

- kind:

  Type of eclipse: 0 = partial, 1 = annular, 2 = total.

- partial_begin:

  Start of partial eclipse (list with `time` and `altitude`).

- total_begin:

  Start of total/annular eclipse (list with `time` and `altitude`).

- peak:

  Peak of eclipse (list with `time` and `altitude`).

- total_end:

  End of total/annular eclipse (list with `time` and `altitude`).

- partial_end:

  End of partial eclipse (list with `time` and `altitude`).

## Examples

``` r
start <- as.POSIXct("2025-01-01", tz = "UTC")
eclipse <- search_local_solar_eclipse(start, latitude = 37.77, longitude = -122.41)
```
