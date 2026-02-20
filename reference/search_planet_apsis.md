# Search for the next planetary apsis

Finds the date and time of a planet's perihelion (closest approach to
the Sun) or aphelion (farthest distance from the Sun) after a given
time.

## Usage

``` r
search_planet_apsis(body, start_time)
```

## Arguments

- body:

  Integer constant identifying the planet. Use
  `astro_body["PLANET_NAME"]` where `PLANET_NAME` is one of:
  `"MERCURY"`, `"VENUS"`, `"EARTH"`, `"MARS"`, `"JUPITER"`, `"SATURN"`,
  `"URANUS"`, `"NEPTUNE"`, or `"PLUTO"`. Not allowed to be `"SUN"` or
  `"MOON"`.

- start_time:

  A `POSIXct` value indicating the date and time at which to start
  searching for the next perihelion or aphelion.

## Value

A list containing:

- kind:

  An integer flag: 0 for perihelion, 1 for aphelion.

- time:

  A `POSIXct` value representing the date and time of the next planetary
  apsis.

- dist_au:

  The distance from the planet to the Sun in astronomical units.

- dist_km:

  The distance from the planet to the Sun in kilometers.

## Details

The closest point is called perihelion and the farthest point is called
aphelion. To iterate through consecutive alternating perihelion and
aphelion events, call `search_planet_apsis()` once, then use the return
value to call
[`next_planet_apsis()`](https://pkg.mitchelloharawild.com/astronomyengine/reference/next_planet_apsis.md).
After that, keep feeding the previous return value into another call of
[`next_planet_apsis()`](https://pkg.mitchelloharawild.com/astronomyengine/reference/next_planet_apsis.md)
as many times as desired.

## See also

[`next_planet_apsis()`](https://pkg.mitchelloharawild.com/astronomyengine/reference/next_planet_apsis.md)

## Examples

``` r
# Find the next perihelion/aphelion of Mars after 2025-01-01
start <- as.POSIXct("2025-01-01", tz = "UTC")
apsis <- search_planet_apsis(astro_body["MARS"], start)
apsis
#> $kind
#> [1] 1
#> 
#> $time
#> [1] "2025-04-16 22:54:51 UTC"
#> 
#> $dist_au
#> [1] 1.666058
#> 
#> $dist_km
#> [1] 249238699
#> 
```
