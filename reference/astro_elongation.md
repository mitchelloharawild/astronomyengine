# Elongation of a celestial body

Determines visibility of a celestial body relative to the Sun, as seen
from the Earth. Returns information about the elongation angle and
whether the body is best observed in the morning or evening.

## Usage

``` r
astro_elongation(body, time)
```

## Arguments

- body:

  Integer code identifying the celestial body.

- time:

  A POSIXct date-time value indicating the observation time.

## Value

A list with the following elements:

- visibility:

  Integer flag indicating morning (0) or evening (1) visibility.

- elongation:

  The angle in degrees between the Earth-Sun and Earth-body vectors.
  Range: \[0, 180\].

- ecliptic_separation:

  The absolute difference in ecliptic longitude between the body and the
  Sun. Range: \[0, 180\].

- time:

  A POSIXct value representing the observation time.

- status:

  Status code from the underlying C function.

## Examples

``` r
time <- as.POSIXct("2025-06-15 12:00:00", tz = "UTC")
astro_elongation(body = astro_body["MERCURY"], time = time)
#> $visibility
#> [1] 1
#> 
#> $elongation
#> [1] 17.95865
#> 
#> $ecliptic_separation
#> [1] 17.84749
#> 
#> $time
#> [1] "2025-06-15 12:00:00 UTC"
#> 
#> $status
#> [1] 0
#> 
```
