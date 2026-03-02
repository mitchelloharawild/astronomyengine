# Angle from the Sun

Returns the angle between a celestial body and the Sun, as seen from the
center of the Earth. This angle helps determine how easy it is to see
the body away from the glare of the Sun.

## Usage

``` r
astro_angle_from_sun(body, time)
```

## Arguments

- body:

  Integer code identifying the celestial body. Must not be Earth.

- time:

  A POSIXct date-time value indicating the observation time.

## Value

A list with the following elements:

- angle:

  The angle in degrees between the Sun and the body as seen from the
  center of the Earth.

- status:

  Status code from the underlying C function.

## Examples

``` r
time <- as.POSIXct("2025-06-15 12:00:00", tz = "UTC")
astro_angle_from_sun(body = astro_body["MERCURY"], time = time)
#> [1] 17.95865
```
