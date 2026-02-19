# Re-orient a rotation matrix by pivoting around an axis

Given a rotation matrix, a selected coordinate axis, and an angle in
degrees, this function pivots the rotation matrix by that angle around
that coordinate axis.

## Usage

``` r
astro_pivot(rotation, axis, angle)
```

## Arguments

- rotation:

  The input rotation matrix

- axis:

  An integer that selects which coordinate axis to rotate around: 0 = x,
  1 = y, 2 = z. Any other value will fail with an error.

- angle:

  An angle in degrees indicating the amount of rotation around the
  specified axis. Positive angles indicate rotation counterclockwise as
  seen from the positive direction along that axis, looking towards the
  origin point of the orientation system. Any finite number of degrees
  is allowed, but best precision will result from keeping `angle` in the
  range \[-360, +360\].

## Value

A pivoted rotation matrix

## Details

For example, if you have rotation matrix that converts ecliptic
coordinates (ECL) to horizontal coordinates (HOR), but you really want
to convert ECL to the orientation of a telescope camera pointed at a
given body, you can use `astro_pivot()` twice: (1) pivot around the
zenith axis by the body's azimuth, then (2) pivot around the western
axis by the body's altitude angle. The resulting rotation matrix will
then reorient ECL coordinates to the orientation of your telescope
camera.

## Examples

``` r
# Create an identity matrix and pivot it
rot <- astro_identity_matrix()
pivoted <- astro_pivot(rot, axis = 2, angle = 45)  # Rotate 45° around z-axis
```
