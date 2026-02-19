# Search for relative longitude event between Earth and another planet

Searches for the next time when the relative longitude (angle measured
in the ecliptic plane from one planet to another as seen from the Sun)
reaches a specified target angle.

## Usage

``` r
astro_search_relative_longitude(body, target_rel_lon, start_time)
```

## Arguments

- body:

  An integer representing a planet other than Earth (see
  `[astro_body]`). Cannot be the Earth, Moon, or Sun.

- target_rel_lon:

  Numeric. The desired relative longitude in degrees. Must be in the
  range \[0, 360).

- start_time:

  A `POSIXct` datetime object specifying when to begin the search.

## Value

A `POSIXct` datetime object indicating when the target relative
longitude is reached.

## Details

Relative longitude defines several important astronomical events:

- 0°:

  Conjunction (inferior for Mercury/Venus, opposition for outer planets)

- 180°:

  Superior conjunction (planet on opposite side of Sun from Earth)

For planets orbiting closer to the Sun than Earth (Mercury, Venus), a
relative longitude of 0° indicates inferior conjunction. For planets
orbiting farther from the Sun, 0° indicates opposition (closest
approach).

## Examples

``` r
# Find next opposition of Mars after 2025-01-01
start <- as.POSIXct("2025-01-01", tz = "UTC")
astro_search_relative_longitude(astro_body["MARS"], 0, start)
#> [1] "2025-01-16 02:30:12 UTC"
```
