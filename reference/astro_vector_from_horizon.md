# Convert Horizontal Coordinates to Cartesian Vector

Given apparent angular horizontal coordinates, calculates a horizontal
Cartesian vector.

Given apparent angular horizontal coordinates, calculate horizontal
vector. The input azimuth is measured in degrees clockwise from north
(east = +90). The returned vector is in the horizontal system: x =
north, y = west, z = zenith (up).

## Usage

``` r
astro_vector_from_horizon(sphere, time, refraction = 1L)

astro_vector_from_horizon(sphere, time, refraction = 1L)
```

## Arguments

- sphere:

  A list with components:

  lat

  :   Refracted altitude angle in degrees

  lon

  :   Azimuth in degrees clockwise from north

  dist

  :   Distance from the observer to the object in AU

- time:

  POSIXct time of the observation

- refraction:

  Refraction option (0 = REFRACTION_NONE, 1 = REFRACTION_NORMAL, 2 =
  REFRACTION_JPLHOR). This specifies how refraction is to be removed
  from the altitude stored in `sphere$lat`.

## Value

A list representing a horizontal Cartesian vector with elements:

- `x`: North component in AU

- `y`: West component in AU

- `z`: Zenith (up) component in AU

- `t`: Time value

- `status`: Status code (0 = success)

A list representing a vector in the horizontal system with components:

- x:

  North component in AU

- y:

  West component in AU

- z:

  Zenith (up) component in AU

- t:

  The date and time (POSIXct)

- status:

  Status code (0 = success)

## Examples

``` r
# 30° altitude, facing south
hor <- list(lat = 30, lon = 180, dist = 1)
time <- as.POSIXct("2024-01-01 12:00:00", tz = "UTC")
vec <- astro_vector_from_horizon(hor, time, refraction = 1)

# Convert horizontal coordinates to vector
sphere <- list(lat = 45, lon = 90, dist = 1)  # 45° altitude, 90° azimuth (east)
time <- as.POSIXct("2024-01-01 12:00:00", tz = "UTC")
vec <- astro_vector_from_horizon(sphere, time, refraction = 1)
```
