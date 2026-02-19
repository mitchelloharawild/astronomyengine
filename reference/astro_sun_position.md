# Sun's position in ecliptic coordinates

Calculates the geocentric ecliptic coordinates of the Sun. The returned
coordinates are based on the true equinox of date (the instantaneous
intersection of the Earth's equatorial plane and the ecliptic plane at
the given time).

## Usage

``` r
astro_sun_position(time)
```

## Arguments

- time:

  A `POSIXct` object representing the date and time.

## Value

A list containing:

- elon:

  Ecliptic longitude in degrees.

- elat:

  Ecliptic latitude in degrees.

- vec:

  A list with Cartesian coordinates:

  x

  :   X-coordinate in AU.

  y

  :   Y-coordinate in AU.

  z

  :   Z-coordinate in AU.

  t

  :   Time as `POSIXct`.

## Details

This function accounts for light travel time from the Sun and corrects
for precession and nutation of the Earth's axis.

## Examples

``` r
time <- as.POSIXct("2025-03-20 09:00:00", tz = "UTC")
astro_sun_position(time)
#> $elon
#> [1] 359.999
#> 
#> $elat
#> [1] 6.651003e-05
#> 
#> $vec
#> $vec$x
#> [1] 0.995888
#> 
#> $vec$y
#> [1] -1.734101e-05
#> 
#> $vec$z
#> [1] 1.156046e-06
#> 
#> $vec$t
#> [1] "2025-03-20 09:00:00 UTC"
#> 
#> 
```
