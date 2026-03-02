# Illumination data for a celestial body

Calculates visual magnitude, phase angle, and related illumination
information for a celestial body as seen from Earth.

## Usage

``` r
astro_illumination(body, time)
```

## Arguments

- body:

  An integer representing a celestial body (see `[astro_body]`). Cannot
  be Earth.

- time:

  A `POSIXct` datetime object.

## Value

A list containing:

- time:

  The input time as a `POSIXct` object.

- mag:

  Visual magnitude (numeric).

- phase_angle:

  Phase angle in degrees (numeric).

- phase_fraction:

  Fraction of the body illuminated from 0 to 1 (numeric).

- helio_dist:

  Distance from Sun in AU (numeric).

- ring_tilt:

  Saturn's ring tilt in degrees, 0 for other bodies (numeric).

## Details

Visual magnitude is a measure of brightness, where smaller (or negative)
values indicate brighter objects and larger values indicate dimmer
objects.

Phase angle is the angle in degrees between the Sun and Earth as seen
from the body's center. It indicates what fraction of the body appears
illuminated from Earth:

- Phase angle near 0° means the body appears "full"

- Phase angle near 90° means the body appears "half full"

- Phase angle near 180° means the body appears as a thin crescent

For Saturn, the returned list includes `ring_tilt`, which is the tilt
angle in degrees of Saturn's rings as seen from Earth (0° means edge-on
and nearly invisible).

## Examples

``` r
# Get illumination data for Mars on 2025-06-21
time <- as.POSIXct("2025-06-21", tz = "UTC")
astro_illumination(astro_body["MARS"], time)
#> $time
#> [1] "2025-06-21 UTC"
#> 
#> $mag
#> [1] 1.43002
#> 
#> $phase_angle
#> [1] 33.10373
#> 
#> $phase_fraction
#> [1] 0.9188416
#> 
#> $helio_dist
#> [1] 1.645307
#> 
#> $ring_tilt
#> [1] 0
#> 
```
