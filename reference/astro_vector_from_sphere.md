# Convert Spherical Coordinates to Cartesian Vector

Given spherical coordinates and a time at which they are valid, returns
a vector of Cartesian coordinates. The returned value includes the time,
as required by the vector structure.

Given spherical coordinates and a time at which they are valid, returns
a vector of Cartesian coordinates. The returned value includes the time,
as required by the vector type.

## Usage

``` r
astro_vector_from_sphere(sphere, time)

astro_vector_from_sphere(sphere, time)
```

## Arguments

- sphere:

  A list with components:

  lat

  :   Latitude angle: -90..+90 degrees

  lon

  :   Longitude angle: 0..360 degrees

  dist

  :   Distance in AU

- time:

  POSIXct time at which the coordinates are valid

## Value

A list representing a Cartesian vector with elements:

- `x`, `y`, `z`: Cartesian coordinates in AU

- `t`: Time value

- `status`: Status code (0 = success)

A list representing a vector with components:

- x:

  The Cartesian x-coordinate in AU

- y:

  The Cartesian y-coordinate in AU

- z:

  The Cartesian z-coordinate in AU

- t:

  The date and time (POSIXct) at which this vector is valid

- status:

  Status code (0 = success)

## Examples

``` r
sphere <- list(lat = 45, lon = 90, dist = 1.5)
time <- as.POSIXct("2024-01-01 12:00:00", tz = "UTC")
vec <- astro_vector_from_sphere(sphere, time)

# Convert spherical to Cartesian
sphere <- list(lat = 0, lon = 0, dist = 1)
time <- as.POSIXct("2024-01-01", tz = "UTC")
vec <- astro_vector_from_sphere(sphere, time)
```
