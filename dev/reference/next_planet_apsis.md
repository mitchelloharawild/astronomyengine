# Find the next planetary apsis in a series

Given an aphelion event, this function finds the next perihelion event,
and vice versa. This requires an apsis event obtained from a call to
[`search_planet_apsis()`](https://pkg.mitchelloharawild.com/astronomyengine/dev/reference/search_planet_apsis.md)
or a previous call to `next_planet_apsis()`.

## Usage

``` r
next_planet_apsis(body, apsis)
```

## Arguments

- body:

  Integer constant identifying the planet. Use
  `astro_body["PLANET_NAME"]` where `PLANET_NAME` is one of:
  `"MERCURY"`, `"VENUS"`, `"EARTH"`, `"MARS"`, `"JUPITER"`, `"SATURN"`,
  `"URANUS"`, `"NEPTUNE"`, or `"PLUTO"`. Must match the body passed into
  the call that produced the `apsis` parameter. Not allowed to be
  `"SUN"` or `"MOON"`.

- apsis:

  An apsis event (a list) obtained from a call to
  [`search_planet_apsis()`](https://pkg.mitchelloharawild.com/astronomyengine/dev/reference/search_planet_apsis.md)
  or `next_planet_apsis()`.

## Value

A list with the same structure as returned by
[`search_planet_apsis()`](https://pkg.mitchelloharawild.com/astronomyengine/dev/reference/search_planet_apsis.md):

- kind:

  An integer flag: 0 for perihelion, 1 for aphelion.

- time:

  A `POSIXct` value representing the date and time of the next planetary
  apsis.

- dist_au:

  The distance from the planet to the Sun in astronomical units.

- dist_km:

  The distance from the planet to the Sun in kilometers.

## See also

[`search_planet_apsis()`](https://pkg.mitchelloharawild.com/astronomyengine/dev/reference/search_planet_apsis.md)

## Examples

``` r
# Find successive apsis events for Mars
start <- as.POSIXct("2025-01-01", tz = "UTC")
apsis1 <- search_planet_apsis(astro_body["MARS"], start)
apsis2 <- next_planet_apsis(astro_body["MARS"], apsis1)
apsis3 <- next_planet_apsis(astro_body["MARS"], apsis2)
```
