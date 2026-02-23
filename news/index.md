# Changelog

## astronomyengine 0.1.0

Initial CRAN release of astronomyengine package

### New features

- R bindings to the Astronomy Engine C library, providing accurate
  astronomical calculations
- Support for calculating positions of the Sun, Moon, and planets
- Single-file header + source bundling of the Astronomy Engine C library
  for use by other R packages via `LinkingTo`
- Accuracy of approximately ±1 arcminute based on the VSOP87 planetary
  model
- Full support for location-based calculations based on longitude,
  latitude, and height
- POSIXct time input for all functions with UTC timezone support
