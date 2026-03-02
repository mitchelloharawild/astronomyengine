# Convert Cartesian Vector to Equatorial Coordinates

Given an equatorial vector, calculates equatorial angular coordinates
(right ascension and declination).

Given an equatorial vector, calculates equatorial angular coordinates
(right ascension and declination).

## Usage

``` r
astro_equator_from_vector(vector)

astro_equator_from_vector(vector)
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

A list representing equatorial coordinates with elements:

- `ra`: Right ascension in sidereal hours (0-24)

- `dec`: Declination in degrees (-90 to +90)

- `dist`: Distance in AU

- `vec`: The original vector

- `status`: Status code (0 = success)

A list with components:

- ra:

  Right ascension in sidereal hours

- dec:

  Declination in degrees

- dist:

  Distance to the celestial body in AU

- vec:

  Equatorial coordinates in Cartesian vector form

- status:

  Status code (0 = success)

## Examples

``` r
vec <- list(x = 1, y = 0.5, z = 0.25, t = as.POSIXct("2024-01-01", tz = "UTC"))
equ <- astro_equator_from_vector(vec)

# Convert vector to equatorial coordinates
vec <- list(x = 1, y = 0, z = 0, t = as.POSIXct("2024-01-01", tz = "UTC"))
equ <- astro_equator_from_vector(vec)
```
