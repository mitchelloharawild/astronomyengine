# Calculate the hour angle of a body

Finds the hour angle of a body for a given observer and time. The hour
angle indicates the body's position in the sky with respect to Earth's
rotation.

## Usage

``` r
astro_hour_angle(body, time, latitude, longitude, height = 0)
```

## Arguments

- body:

  Integer body code (see
  [astro_body](https://pkg.mitchelloharawild.com/astronomyengine/reference/astro_body.md)).

- time:

  A `POSIXct` date/time in UTC.

- latitude:

  Observer's geographic latitude in degrees.

- longitude:

  Observer's geographic longitude in degrees.

- height:

  Observer's height above sea level in metres. Default `0`.

## Value

A numeric value representing the hour angle in the range \[0, 24), where
each unit is one sidereal hour.

## Details

The hour angle is 0 when the body culminates (reaches its highest
point), and increases by 1 unit for every sidereal hour that passes. A
value of 12 means the body is at its lowest point. A value of 24 is
equivalent to 0.

## Examples

``` r
t <- as.POSIXct("2025-06-21 12:00:00", tz = "UTC")
astro_hour_angle(astro_body[["SUN"]], t,
                 latitude = -33.8688, longitude = 151.2093)
#> [1] 10.04974
```
