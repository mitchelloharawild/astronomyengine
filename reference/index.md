# Package index

## Dates and times

Functions for creating and manipulating time values for astronomy
calculations.

- [`astro_current_time()`](https://pkg.mitchelloharawild.com/astronomyengine/reference/astro_current_time.md)
  : Current UTC time according to Astronomy Engine
- [`astro_make_time()`](https://pkg.mitchelloharawild.com/astronomyengine/reference/astro_make_time.md)
  : Create an astronomical time value

## Celestial bodies

Functions for working with celestial body identifiers.

- [`astro_body`](https://pkg.mitchelloharawild.com/astronomyengine/reference/astro_body.md)
  : Celestial body codes
- [`astro_body_code()`](https://pkg.mitchelloharawild.com/astronomyengine/reference/astro_body_code.md)
  : Get the integer code for a celestial body by name
- [`astro_body_name()`](https://pkg.mitchelloharawild.com/astronomyengine/reference/astro_body_name.md)
  : Get the name of a celestial body

## Position of Sun, Moon, and planets

Calculate positions of celestial bodies as seen from Earth or the Sun.

- [`astro_helio_vector()`](https://pkg.mitchelloharawild.com/astronomyengine/reference/astro_helio_vector.md)
  : Heliocentric position vector of a celestial body
- [`astro_geo_vector()`](https://pkg.mitchelloharawild.com/astronomyengine/reference/astro_geo_vector.md)
  : Geocentric position vector of a celestial body
- [`astro_equator()`](https://pkg.mitchelloharawild.com/astronomyengine/reference/astro_equator.md)
  : Topocentric equatorial coordinates of a celestial body
- [`astro_ecliptic()`](https://pkg.mitchelloharawild.com/astronomyengine/reference/astro_ecliptic.md)
  : Convert J2000 equatorial coordinates to ecliptic coordinates
- [`astro_ecliptic_longitude()`](https://pkg.mitchelloharawild.com/astronomyengine/reference/astro_ecliptic_longitude.md)
  : Heliocentric ecliptic longitude of a body
- [`astro_horizon()`](https://pkg.mitchelloharawild.com/astronomyengine/reference/astro_horizon.md)
  : Horizontal coordinates of a celestial body
- [`astro_pair_longitude()`](https://pkg.mitchelloharawild.com/astronomyengine/reference/astro_pair_longitude.md)
  : Ecliptic longitude of one body relative to another
- [`astro_bary_state()`](https://pkg.mitchelloharawild.com/astronomyengine/reference/astro_bary_state.md)
  : Barycentric position and velocity vectors

## Geographic helper functions

Functions for working with observer locations on Earth.

- [`astro_observer_vector()`](https://pkg.mitchelloharawild.com/astronomyengine/reference/astro_observer_vector.md)
  : Observer position vector from geographic coordinates
- [`astro_vector_observer()`](https://pkg.mitchelloharawild.com/astronomyengine/reference/astro_vector_observer.md)
  : Geographic coordinates from observer position vector

## Rise, set, and culmination times

Find times when celestial bodies rise, set, or reach specific altitudes.

- [`astro_search_rise_set()`](https://pkg.mitchelloharawild.com/astronomyengine/reference/astro_search_rise_set.md)
  : Search for the next rise or set time of a celestial body
- [`astro_search_altitude()`](https://pkg.mitchelloharawild.com/astronomyengine/reference/astro_search_altitude.md)
  : Search for when a body reaches a specified altitude
- [`astro_search_hour_angle()`](https://pkg.mitchelloharawild.com/astronomyengine/reference/astro_search_hour_angle.md)
  : Search for when a body reaches a specified hour angle
- [`astro_hour_angle()`](https://pkg.mitchelloharawild.com/astronomyengine/reference/astro_hour_angle.md)
  : Calculate the hour angle of a body

## Moon phases

Calculate and search for specific Moon phases.

- [`astro_moon_phase()`](https://pkg.mitchelloharawild.com/astronomyengine/reference/astro_moon_phase.md)
  : Moon Phase Angle
- [`astro_search_moon_phase()`](https://pkg.mitchelloharawild.com/astronomyengine/reference/astro_search_moon_phase.md)
  : Search for a Specific Moon Phase
- [`astro_search_moon_quarter()`](https://pkg.mitchelloharawild.com/astronomyengine/reference/astro_search_moon_quarter.md)
  : Find First Lunar Quarter
- [`astro_next_moon_quarter()`](https://pkg.mitchelloharawild.com/astronomyengine/reference/astro_next_moon_quarter.md)
  : Find Next Lunar Quarter

## Eclipses and Transits

Search for lunar eclipses, solar eclipses, and planetary transits.

- [`astro_search_lunar_eclipse()`](https://pkg.mitchelloharawild.com/astronomyengine/reference/astro_search_lunar_eclipse.md)
  : Search for a lunar eclipse
- [`astro_next_lunar_eclipse()`](https://pkg.mitchelloharawild.com/astronomyengine/reference/astro_next_lunar_eclipse.md)
  : Find the next lunar eclipse in a series
- [`search_global_solar_eclipse()`](https://pkg.mitchelloharawild.com/astronomyengine/reference/search_global_solar_eclipse.md)
  : Search for a global solar eclipse
- [`next_global_solar_eclipse()`](https://pkg.mitchelloharawild.com/astronomyengine/reference/next_global_solar_eclipse.md)
  : Search for the next global solar eclipse
- [`search_local_solar_eclipse()`](https://pkg.mitchelloharawild.com/astronomyengine/reference/search_local_solar_eclipse.md)
  : Search for a local solar eclipse
- [`next_local_solar_eclipse()`](https://pkg.mitchelloharawild.com/astronomyengine/reference/next_local_solar_eclipse.md)
  : Search for the next local solar eclipse
- [`astro_search_transit()`](https://pkg.mitchelloharawild.com/astronomyengine/reference/astro_search_transit.md)
  : Search for a transit of Mercury or Venus
- [`astro_next_transit()`](https://pkg.mitchelloharawild.com/astronomyengine/reference/astro_next_transit.md)
  : Search for the next transit of Mercury or Venus

## Lunar perigee and apogee

Find times of the Moon’s closest and farthest points from Earth.

- [`search_lunar_apsis()`](https://pkg.mitchelloharawild.com/astronomyengine/reference/search_lunar_apsis.md)
  : Search for lunar apsis events
- [`next_lunar_apsis()`](https://pkg.mitchelloharawild.com/astronomyengine/reference/next_lunar_apsis.md)
  : Find the next lunar apsis event

## Planetary aphelion and perihelion

Find times of planets’ closest and farthest points from the Sun.

- [`search_planet_apsis()`](https://pkg.mitchelloharawild.com/astronomyengine/reference/search_planet_apsis.md)
  : Search for the next planetary apsis
- [`next_planet_apsis()`](https://pkg.mitchelloharawild.com/astronomyengine/reference/next_planet_apsis.md)
  : Find the next planetary apsis in a series

## Visual magnitude and elongation

Calculate brightness and angular separation of celestial bodies.

- [`astro_illumination()`](https://pkg.mitchelloharawild.com/astronomyengine/reference/astro_illumination.md)
  : Illumination data for a celestial body
- [`astro_search_peak_magnitude()`](https://pkg.mitchelloharawild.com/astronomyengine/reference/astro_search_peak_magnitude.md)
  : Search for peak magnitude of Venus
- [`astro_angle_from_sun()`](https://pkg.mitchelloharawild.com/astronomyengine/reference/astro_angle_from_sun.md)
  : Angle from the Sun
- [`astro_elongation()`](https://pkg.mitchelloharawild.com/astronomyengine/reference/astro_elongation.md)
  : Elongation of a celestial body
- [`astro_search_max_elongation()`](https://pkg.mitchelloharawild.com/astronomyengine/reference/astro_search_max_elongation.md)
  : Search for maximum elongation

## Oppositions and conjunctions

Find when planets reach specific relative positions.

- [`astro_search_relative_longitude()`](https://pkg.mitchelloharawild.com/astronomyengine/reference/astro_search_relative_longitude.md)
  : Search for relative longitude event between Earth and another planet

## Equinoxes, solstices, and apparent solar motion

Find equinoxes, solstices, and track the Sun’s position.

- [`astro_search_sun_longitude()`](https://pkg.mitchelloharawild.com/astronomyengine/reference/astro_search_sun_longitude.md)
  : Search for Sun longitude
- [`astro_seasons()`](https://pkg.mitchelloharawild.com/astronomyengine/reference/astro_seasons.md)
  : Equinoxes and Solstices for a Given Year
- [`astro_sun_position()`](https://pkg.mitchelloharawild.com/astronomyengine/reference/astro_sun_position.md)
  : Sun's position in ecliptic coordinates

## Coordinate transforms

Convert between different astronomical coordinate systems and
representations.

- [`astro_rotate_vector()`](https://pkg.mitchelloharawild.com/astronomyengine/reference/astro_rotate_vector.md)
  : Apply a rotation to a vector
- [`astro_inverse_rotation()`](https://pkg.mitchelloharawild.com/astronomyengine/reference/astro_inverse_rotation.md)
  : Calculate the inverse of a rotation matrix
- [`astro_combine_rotation()`](https://pkg.mitchelloharawild.com/astronomyengine/reference/astro_combine_rotation.md)
  : Combine two rotation matrices
- [`astro_identity_matrix()`](https://pkg.mitchelloharawild.com/astronomyengine/reference/astro_identity_matrix.md)
  : Create an identity rotation matrix
- [`astro_pivot()`](https://pkg.mitchelloharawild.com/astronomyengine/reference/astro_pivot.md)
  : Re-orient a rotation matrix by pivoting around an axis
- [`astro_vector_from_sphere()`](https://pkg.mitchelloharawild.com/astronomyengine/reference/astro_vector_from_sphere.md)
  : Convert Spherical Coordinates to Cartesian Vector
- [`astro_sphere_from_vector()`](https://pkg.mitchelloharawild.com/astronomyengine/reference/astro_sphere_from_vector.md)
  : Convert Cartesian Vector to Spherical Coordinates
- [`astro_equator_from_vector()`](https://pkg.mitchelloharawild.com/astronomyengine/reference/astro_equator_from_vector.md)
  : Convert Cartesian Vector to Equatorial Coordinates
- [`astro_vector_from_horizon()`](https://pkg.mitchelloharawild.com/astronomyengine/reference/astro_vector_from_horizon.md)
  : Convert Horizontal Coordinates to Cartesian Vector
- [`astro_horizon_from_vector()`](https://pkg.mitchelloharawild.com/astronomyengine/reference/astro_horizon_from_vector.md)
  : Convert Cartesian Vector to Horizontal Coordinates
- [`astro_rotation_EQD_EQJ()`](https://pkg.mitchelloharawild.com/astronomyengine/reference/astro_rotation_EQD_EQJ.md)
  : Rotation Matrix from EQD to EQJ
- [`astro_rotation_EQD_ECT()`](https://pkg.mitchelloharawild.com/astronomyengine/reference/astro_rotation_EQD_ECT.md)
  : Rotation Matrix from EQD to ECT
- [`astro_rotation_EQD_ECL()`](https://pkg.mitchelloharawild.com/astronomyengine/reference/astro_rotation_EQD_ECL.md)
  : Rotation Matrix from Equatorial of-Date to J2000 Ecliptic
- [`astro_rotation_EQD_HOR()`](https://pkg.mitchelloharawild.com/astronomyengine/reference/astro_rotation_EQD_HOR.md)
  : Rotation Matrix from EQD to HOR
- [`astro_rotation_EQJ_EQD()`](https://pkg.mitchelloharawild.com/astronomyengine/reference/astro_rotation_EQJ_EQD.md)
  : Rotation Matrix from EQJ to EQD
- [`astro_rotation_EQJ_ECT()`](https://pkg.mitchelloharawild.com/astronomyengine/reference/astro_rotation_EQJ_ECT.md)
  : Rotation Matrix from EQJ to ECT
- [`astro_rotation_EQJ_ECL()`](https://pkg.mitchelloharawild.com/astronomyengine/reference/astro_rotation_EQJ_ECL.md)
  : Rotation Matrix from EQJ to ECL
- [`astro_rotation_EQJ_HOR()`](https://pkg.mitchelloharawild.com/astronomyengine/reference/astro_rotation_EQJ_HOR.md)
  : Rotation Matrix from J2000 Equatorial to Horizontal
- [`astro_rotation_ECT_EQD()`](https://pkg.mitchelloharawild.com/astronomyengine/reference/astro_rotation_ECT_EQD.md)
  : Rotation Matrix from ECT to EQD
- [`astro_rotation_ECT_EQJ()`](https://pkg.mitchelloharawild.com/astronomyengine/reference/astro_rotation_ECT_EQJ.md)
  : Rotation Matrix from ECT to EQJ
- [`astro_rotation_ECL_EQD()`](https://pkg.mitchelloharawild.com/astronomyengine/reference/astro_rotation_ECL_EQD.md)
  : Rotation Matrix from J2000 Ecliptic to Equatorial of-Date
- [`astro_rotation_ECL_EQJ()`](https://pkg.mitchelloharawild.com/astronomyengine/reference/astro_rotation_ECL_EQJ.md)
  : Rotation Matrix from ECL to EQJ
- [`astro_rotation_ECL_HOR()`](https://pkg.mitchelloharawild.com/astronomyengine/reference/astro_rotation_ECL_HOR.md)
  : Rotation Matrix from ECL to HOR
- [`astro_rotation_HOR_EQD()`](https://pkg.mitchelloharawild.com/astronomyengine/reference/astro_rotation_HOR_EQD.md)
  : Rotation Matrix from HOR to EQD
- [`astro_rotation_HOR_EQJ()`](https://pkg.mitchelloharawild.com/astronomyengine/reference/astro_rotation_HOR_EQJ.md)
  : Rotation Matrix from Horizontal to J2000 Equatorial
- [`astro_rotation_HOR_ECL()`](https://pkg.mitchelloharawild.com/astronomyengine/reference/astro_rotation_HOR_ECL.md)
  : Rotation Matrix from HOR to ECL
- [`astro_rotation_EQJ_GAL()`](https://pkg.mitchelloharawild.com/astronomyengine/reference/astro_rotation_EQJ_GAL.md)
  : Rotation Matrix from EQJ to GAL
- [`astro_rotation_GAL_EQJ()`](https://pkg.mitchelloharawild.com/astronomyengine/reference/astro_rotation_GAL_EQJ.md)
  : Rotation Matrix from GAL to EQJ

## Observer state

Functions for calculating observer-related state information.

- [`astro_observer_state()`](https://pkg.mitchelloharawild.com/astronomyengine/reference/astro_observer_state.md)
  : Observer position and velocity vector from geographic coordinates
- [`astro_observer_gravity()`](https://pkg.mitchelloharawild.com/astronomyengine/reference/astro_observer_gravity.md)
  : Observer gravitational acceleration
- [`astro_body`](https://pkg.mitchelloharawild.com/astronomyengine/reference/astro_body.md)
  : Celestial body codes
