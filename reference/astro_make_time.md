# Create an astronomical time value

Given a UTC calendar date and time, calculates a POSIXct value that can
be passed to other Astronomy Engine functions for performing various
calculations relating to that date and time.

## Usage

``` r
astro_make_time(year, month, day, hour = 0L, minute = 0L, second = 0)
```

## Arguments

- year:

  Integer UTC calendar year (e.g. 2025).

- month:

  Integer UTC calendar month in the range 1–12.

- day:

  Integer UTC calendar day in the range 1–31.

- hour:

  Integer UTC hour of the day in the range 0–23. Default 0.

- minute:

  Integer UTC minute in the range 0–59. Default 0.

- second:

  Numeric UTC floating-point second in the range \[0, 60). Default 0.

## Value

A `POSIXct` value in UTC that represents the given calendar date and
time.

## Details

It is the caller's responsibility to ensure that the parameter values
are correct. The parameters are not checked for validity, and this
function never returns any indication of an error. Invalid values, for
example passing in February 31, may cause unexpected return values.

## Examples

``` r
astro_make_time(2025, 6, 21)
#> [1] "2025-06-21 UTC"
astro_make_time(2025, 6, 21, 12, 30, 0)
#> [1] "2025-06-21 12:30:00 UTC"
```
