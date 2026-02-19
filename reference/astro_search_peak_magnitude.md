# Search for peak magnitude of Venus

Searches for the next date and time when Venus will appear brightest as
seen from Earth. This function currently only supports Venus.

## Usage

``` r
astro_search_peak_magnitude(body, start_time)
```

## Arguments

- body:

  An integer representing the celestial body. Currently only
  `astro_body["VENUS"]` is supported. Returns error for other bodies.

- start_time:

  A `POSIXct` datetime object specifying when to begin the search.

## Value

A list containing:

- time:

  The time of peak magnitude as a `POSIXct` object.

- mag:

  Visual magnitude at peak brightness (numeric).

- phase_angle:

  Phase angle in degrees (numeric).

- phase_fraction:

  Fraction of Venus illuminated (numeric).

- helio_dist:

  Distance from Sun in AU (numeric).

- ring_tilt:

  Always 0 for Venus (numeric).

## Details

Venus reaches peak magnitude (maximum brightness) at certain times in
its orbit. This is distinct from other brightness events: Mercury's peak
magnitude occurs at superior conjunction when it's invisible, and outer
planets reach peak magnitude at opposition.

The search may require iterating through multiple synodic periods of
Venus to find an event after the specified start time. The function will
search forward from the start time until it finds a valid peak magnitude
event.

## Examples

``` r
# Find when Venus will next reach peak magnitude after 2025-01-01
start <- as.POSIXct("2025-01-01", tz = "UTC")
astro_search_peak_magnitude(astro_body["VENUS"], start)
#> $time
#> [1] "2025-02-17 10:02:11 UTC"
#> 
#> $mag
#> [1] -4.850427
#> 
#> $phase_angle
#> [1] 119.7786
#> 
#> $phase_fraction
#> [1] 0.2516749
#> 
#> $helio_dist
#> [1] 0.7184612
#> 
#> $ring_tilt
#> [1] 0
#> 
```
