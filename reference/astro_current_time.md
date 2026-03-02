# Current UTC time according to Astronomy Engine

Uses the computer's system clock to find the current UTC date and time.
Converts that date and time to a POSIXct value and returns the result.
Callers can pass this value to other Astronomy Engine functions to
calculate current observational conditions.

## Usage

``` r
astro_current_time()
```

## Value

A `POSIXct` value representing the current UTC date and time.

## Details

On supported platforms (Linux/Unix, Mac, Windows), the time is measured
with microsecond resolution.

## Examples

``` r
astro_current_time()
#> [1] "2026-03-02 06:06:52 UTC"
```
