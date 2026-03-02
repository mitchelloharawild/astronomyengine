# Geographic coordinates from observer position vector

Given a geocentric equatorial position vector, calculates the geographic
latitude, longitude, and elevation of the observer on Earth's surface.
This is the inverse function of
[`astro_observer_vector()`](https://pkg.mitchelloharawild.com/astronomyengine/dev/reference/astro_observer_vector.md).

## Usage

``` r
astro_vector_observer(vector, of_date = FALSE)
```

## Arguments

- vector:

  A list with components representing the observer's position vector:

  x

  :   Equatorial x-coordinate in AU

  y

  :   Equatorial y-coordinate in AU

  z

  :   Equatorial z-coordinate in AU

  t

  :   The time (POSIXct) at which the vector is valid

  The components are expressed in Astronomical Units (AU). Divide
  kilometers by \#KM_PER_AU to convert to AU.

- of_date:

  Logical. If `TRUE`, interprets `vector` as equator-of-date
  coordinates. If `FALSE` (default), interprets it as J2000 coordinates.

## Value

A list with components:

- latitude:

  Geographic latitude in degrees north of the equator (range: -90 to
  +90)

- longitude:

  Geographic longitude in degrees east of the prime meridian (range: 0
  to 360)

- height:

  Elevation above sea level in meters

## Examples

``` r
# Convert a position vector back to geographic coordinates
obs_vec <- list(
  x = 0.00005, y = 0.00005, z = 0.00005,
  t = as.POSIXct("2024-01-01 12:00:00", tz = "UTC")
)
obs <- astro_vector_observer(obs_vec)
obs
#> $latitude
#> [1] 35.44905
#> 
#> $longitude
#> [1] 124.7278
#> 
#> $height
#> [1] 6584589
#> 
```
