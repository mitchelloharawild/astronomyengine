# Observer gravitational acceleration

Calculates the effective gravitational acceleration experienced by an
observer on the Earth's surface. This combines inward gravitational
acceleration with outward centrifugal acceleration due to Earth's
rotation.

## Usage

``` r
astro_observer_gravity(latitude, height)
```

## Arguments

- latitude:

  The geographic latitude of the observer in degrees north of the
  equator (range: -90 to +90). By formula symmetry, only the absolute
  value of latitude matters.

- height:

  The elevation above sea level in meters. Accuracy is best in the range
  0 to 100,000 meters.

## Value

The effective gravitational acceleration in meters per second squared
(m/s²).

The returned value increases toward the Earth's poles and decreases
toward the equator, consistent with the weight measured by a spring
scale of a fixed mass moved to different latitudes and heights on Earth.

## Details

This function implements the WGS 84 Ellipsoidal Gravity Formula, which
accounts for the Earth's oblate spheroid shape and rotation.

## Examples

``` r
# Calculate gravity at sea level in different locations
gravity_equator <- astro_observer_gravity(latitude = 0, height = 0)
gravity_pole <- astro_observer_gravity(latitude = 90, height = 0)
gravity_sydney <- astro_observer_gravity(latitude = -33.8688, height = 0)

# Gravity is stronger at the poles
cat(sprintf("Equator: %.6f m/s²\n", gravity_equator))
#> Equator: 9.780325 m/s²
cat(sprintf("Pole: %.6f m/s²\n", gravity_pole))
#> Pole: 9.832185 m/s²
cat(sprintf("Sydney: %.6f m/s²\n", gravity_sydney))
#> Sydney: 9.796383 m/s²
```
