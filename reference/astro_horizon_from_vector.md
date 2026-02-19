# Convert Cartesian Vector to Horizontal Coordinates

Given a horizontal Cartesian vector, returns horizontal azimuth and
altitude.

Given a horizontal Cartesian vector, returns horizontal azimuth and
altitude.

## Usage

``` r
astro_horizon_from_vector(vector, refraction = 1L)

astro_horizon_from_vector(vector, refraction = 1L)
```

## Arguments

- vector:

  A list with components:

  x

  :   North component in AU

  y

  :   West component in AU

  z

  :   Zenith (up) component in AU

  t

  :   The date and time (POSIXct)

- refraction:

  Refraction option (0 = REFRACTION_NONE, 1 = REFRACTION_NORMAL, 2 =
  REFRACTION_JPLHOR). REFRACTION_NORMAL: correct altitude for
  atmospheric refraction (recommended). REFRACTION_NONE: no atmospheric
  refraction correction is performed. REFRACTION_JPLHOR: for JPL
  Horizons compatibility testing only; not recommended for normal use.

## Value

A list representing horizontal coordinates with elements:

- `lat`: Altitude in degrees (-90 to +90)

- `lon`: Azimuth in degrees (0-360, clockwise from north)

- `dist`: Distance in AU

- `status`: Status code (0 = success)

A list with components:

- lat:

  Altitude angle in degrees (corrected for refraction if requested)

- lon:

  Azimuth in degrees clockwise from north

- dist:

  Distance in AU

- status:

  Status code (0 = success)

## Details

**IMPORTANT:** This function differs from `astro_sphere_from_vector` in
two ways:

1.  The longitude value represents azimuth defined clockwise from north
    (e.g., east = +90), preserving traditional navigational conventions.

2.  This function optionally corrects for atmospheric refraction.

The returned structure contains the azimuth in the `lon` field, measured
in degrees clockwise from north: east = +90 degrees, west = +270
degrees.

**IMPORTANT:** This function differs from
[`astro_sphere_from_vector()`](https://pkg.mitchelloharawild.com/astronomyengine/reference/astro_sphere_from_vector.md)
in two ways:

- [`astro_sphere_from_vector()`](https://pkg.mitchelloharawild.com/astronomyengine/reference/astro_sphere_from_vector.md)
  returns a `lon` value that represents azimuth defined counterclockwise
  from north (e.g., west = +90), but this function represents a
  clockwise rotation (e.g., east = +90). The difference is because
  [`astro_sphere_from_vector()`](https://pkg.mitchelloharawild.com/astronomyengine/reference/astro_sphere_from_vector.md)
  is intended to preserve the vector "right-hand rule", while this
  function defines azimuth in a more traditional way as used in
  navigation and cartography.

- This function optionally corrects for atmospheric refraction, while
  [`astro_sphere_from_vector()`](https://pkg.mitchelloharawild.com/astronomyengine/reference/astro_sphere_from_vector.md)
  does not.

The returned structure contains the azimuth in `lon`. It is measured in
degrees clockwise from north: east = +90 degrees, west = +270 degrees.

The altitude is stored in `lat`.

The distance to the observed object is stored in `dist`, and is
expressed in astronomical units (AU).

## Examples

``` r
# Vector pointing east at 45° altitude
vec <- list(x = 0, y = -0.707, z = 0.707,
            t = as.POSIXct("2024-01-01", tz = "UTC"))
hor <- astro_horizon_from_vector(vec, refraction = 1)

# Convert horizontal vector to angular coordinates
vec <- list(x = 0, y = -1, z = 0, t = as.POSIXct("2024-01-01", tz = "UTC"))
hor <- astro_horizon_from_vector(vec, refraction = 1)
```
