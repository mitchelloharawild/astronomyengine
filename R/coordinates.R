#' Convert Spherical Coordinates to Cartesian Vector
#'
#' Given spherical coordinates and a time at which they are valid,
#' returns a vector of Cartesian coordinates. The returned value
#' includes the time, as required by the vector structure.
#'
#' @param sphere A list with named elements:
#'   - `lat`: Latitude in degrees (declination-like angle)
#'   - `lon`: Longitude in degrees (right ascension-like angle)
#'   - `dist`: Distance in astronomical units (AU)
#' @param time A POSIXct object representing the date and time.
#'
#' @return A list representing a Cartesian vector with elements:
#'   - `x`, `y`, `z`: Cartesian coordinates in AU
#'   - `t`: Time value
#'   - `status`: Status code (0 = success)
#'
#' @examples
#' sphere <- list(lat = 45, lon = 90, dist = 1.5)
#' time <- as.POSIXct("2024-01-01 12:00:00", tz = "UTC")
#' vec <- astro_vector_from_sphere(sphere, time)
#'
#' @export
astro_vector_from_sphere <- function(sphere, time) {
  astro_vector_from_sphere_(sphere, time)
}


#' Convert Cartesian Vector to Spherical Coordinates
#'
#' Given a Cartesian vector, returns latitude, longitude, and distance
#' in spherical coordinates.
#'
#' @param vector A list with named elements:
#'   - `x`, `y`, `z`: Cartesian coordinates in AU
#'   - `t`: Time value
#'
#' @return A list representing spherical coordinates with elements:
#'   - `lat`: Latitude in degrees
#'   - `lon`: Longitude in degrees (0-360)
#'   - `dist`: Distance in AU
#'   - `status`: Status code (0 = success)
#'
#' @examples
#' vec <- list(x = 1, y = 1, z = 1, t = as.POSIXct("2024-01-01", tz = "UTC"))
#' sphere <- astro_sphere_from_vector(vec)
#'
#' @export
astro_sphere_from_vector <- function(vector) {
  astro_sphere_from_vector_(vector)
}


#' Convert Cartesian Vector to Equatorial Coordinates
#'
#' Given an equatorial vector, calculates equatorial angular coordinates
#' (right ascension and declination).
#'
#' @param vector A list with named elements:
#'   - `x`, `y`, `z`: Cartesian coordinates in AU
#'   - `t`: Time value
#'
#' @return A list representing equatorial coordinates with elements:
#'   - `ra`: Right ascension in sidereal hours (0-24)
#'   - `dec`: Declination in degrees (-90 to +90)
#'   - `dist`: Distance in AU
#'   - `vec`: The original vector
#'   - `status`: Status code (0 = success)
#'
#' @examples
#' vec <- list(x = 1, y = 0.5, z = 0.25, t = as.POSIXct("2024-01-01", tz = "UTC"))
#' equ <- astro_equator_from_vector(vec)
#'
#' @export
astro_equator_from_vector <- function(vector) {
  astro_equator_from_vector_(vector)
}


#' Convert Cartesian Vector to Horizontal Coordinates
#'
#' Given a horizontal Cartesian vector, returns horizontal azimuth and altitude.
#'
#' **IMPORTANT:** This function differs from `astro_sphere_from_vector` in two ways:
#'
#' 1. The longitude value represents azimuth defined clockwise from north
#'    (e.g., east = +90), preserving traditional navigational conventions.
#' 2. This function optionally corrects for atmospheric refraction.
#'
#' The returned structure contains the azimuth in the `lon` field, measured in
#' degrees clockwise from north: east = +90 degrees, west = +270 degrees.
#'
#' @param vector A list with named elements:
#'   - `x`: North component in AU
#'   - `y`: West component in AU
#'   - `z`: Zenith (up) component in AU
#'   - `t`: Time value
#' @param refraction Refraction correction:
#'   - 0 = none
#'   - 1 = normal
#'   - 2 = JPL Horizons compatible (for testing)
#'
#' @return A list representing horizontal coordinates with elements:
#'   - `lat`: Altitude in degrees (-90 to +90)
#'   - `lon`: Azimuth in degrees (0-360, clockwise from north)
#'   - `dist`: Distance in AU
#'   - `status`: Status code (0 = success)
#'
#' @examples
#' # Vector pointing east at 45° altitude
#' vec <- list(x = 0, y = -0.707, z = 0.707,
#'             t = as.POSIXct("2024-01-01", tz = "UTC"))
#' hor <- astro_horizon_from_vector(vec, refraction = 1)
#'
#' @export
astro_horizon_from_vector <- function(vector, refraction) {
  astro_horizon_from_vector_(vector, refraction)
}


#' Convert Horizontal Coordinates to Cartesian Vector
#'
#' Given apparent angular horizontal coordinates, calculates a horizontal
#' Cartesian vector.
#'
#' @param sphere A list with named elements:
#'   - `lat`: Altitude (refracted) in degrees
#'   - `lon`: Azimuth in degrees (clockwise from north)
#'   - `dist`: Distance in AU
#' @param time A POSIXct object representing the date and time.
#' @param refraction Refraction correction to remove:
#'   - 0 = none
#'   - 1 = normal
#'   - 2 = JPL Horizons compatible (for testing)
#'
#' @return A list representing a horizontal Cartesian vector with elements:
#'   - `x`: North component in AU
#'   - `y`: West component in AU
#'   - `z`: Zenith (up) component in AU
#'   - `t`: Time value
#'   - `status`: Status code (0 = success)
#'
#' @examples
#' # 30° altitude, facing south
#' hor <- list(lat = 30, lon = 180, dist = 1)
#' time <- as.POSIXct("2024-01-01 12:00:00", tz = "UTC")
#' vec <- astro_vector_from_horizon(hor, time, refraction = 1)
#'
#' @export
astro_vector_from_horizon <- function(sphere, time, refraction) {
  astro_vector_from_horizon_(sphere, time, refraction)
}
