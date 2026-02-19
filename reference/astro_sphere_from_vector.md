# Convert Cartesian Vector to Spherical Coordinates

Given a Cartesian vector, returns latitude, longitude, and distance in
spherical coordinates.

Given a Cartesian vector, returns latitude, longitude, and distance.

## Usage

``` r
astro_sphere_from_vector(vector)

astro_sphere_from_vector(vector)
```

## Arguments

- vector:

  A list with components:

  x

  :   The Cartesian x-coordinate in AU

  y

  :   The Cartesian y-coordinate in AU

  z

  :   The Cartesian z-coordinate in AU

  t

  :   The date and time (POSIXct) at which this vector is valid

## Value

A list representing spherical coordinates with elements:

- `lat`: Latitude in degrees

- `lon`: Longitude in degrees (0-360)

- `dist`: Distance in AU

- `status`: Status code (0 = success)

A list with components:

- lat:

  Latitude angle: -90..+90 degrees

- lon:

  Longitude angle: 0..360 degrees

- dist:

  Distance in AU

- status:

  Status code (0 = success)

## Examples

``` r
vec <- list(x = 1, y = 1, z = 1, t = as.POSIXct("2024-01-01", tz = "UTC"))
sphere <- astro_sphere_from_vector(vec)

# Convert Cartesian to spherical
vec <- list(x = 1, y = 0, z = 0, t = as.POSIXct("2024-01-01", tz = "UTC"))
sphere <- astro_sphere_from_vector(vec)
```
