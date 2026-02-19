#' Observer position vector from geographic coordinates
#'
#' Calculates the geocentric equatorial position vector of an observer
#' on the surface of the Earth, taking into account the Earth's rotation.
#' This is the inverse function of [astro_vector_observer()].
#'
#' @param time A POSIXct date and time for which to calculate the observer's position vector.
#' @param latitude The geographic latitude of the observer in degrees north of the equator
#'   (range: -90 to +90).
#' @param longitude The geographic longitude of the observer in degrees east of the prime meridian
#'   (range: 0 to 360 or -180 to +180).
#' @param height The elevation of the observer above sea level in meters.
#' @param of_date Logical. If `TRUE`, uses equator-of-date coordinates (Earth's equator at the
#'   given time). If `FALSE` (default), uses J2000 coordinates (Earth's equator on 2000-01-01).
#'
#' @return A list with components:
#'   \describe{
#'     \item{x}{Equatorial x-coordinate in AU}
#'     \item{y}{Equatorial y-coordinate in AU}
#'     \item{z}{Equatorial z-coordinate in AU}
#'     \item{t}{The time (POSIXct) at which the vector is valid}
#'     \item{status}{Status code (0 = success)}
#'   }
#'
#' The vector represents the displacement from Earth's center to the observer,
#' expressed in Astronomical Units (AU). Multiply by #KM_PER_AU to convert to kilometers.
#'
#' @export
#' @examples
#' # Get observer position at Sydney Observatory
#' time <- as.POSIXct("2024-01-01 12:00:00", tz = "UTC")
#' obs_vec <- astro_observer_vector(time, latitude = -33.8688, longitude = 151.2093, height = 0)
#' obs_vec
astro_observer_vector <- function(
  time,
  latitude,
  longitude,
  height,
  of_date = FALSE
) {
  if (!inherits(time, "POSIXct")) {
    stop("time must be a POSIXct object")
  }
  time_posix <- as.numeric(time)
  res <- astro_observer_vector_(
    time_posix,
    latitude,
    longitude,
    height,
    of_date
  )
  res$t <- as.POSIXct(res$t, tz = "UTC")
  res
}

#' Observer position and velocity vector from geographic coordinates
#'
#' Calculates the geocentric equatorial position and velocity vectors of an observer
#' on the surface of the Earth, taking into account the Earth's rotation.
#'
#' @param time A POSIXct date and time for which to calculate the observer's state vector.
#' @param latitude The geographic latitude of the observer in degrees north of the equator
#'   (range: -90 to +90).
#' @param longitude The geographic longitude of the observer in degrees east of the prime meridian
#'   (range: 0 to 360 or -180 to +180).
#' @param height The elevation of the observer above sea level in meters.
#' @param of_date Logical. If `TRUE`, uses equator-of-date coordinates (Earth's equator at the
#'   given time). If `FALSE` (default), uses J2000 coordinates (Earth's equator on 2000-01-01).
#'
#' @return A list with components:
#'   \describe{
#'     \item{x}{Equatorial x-coordinate in AU}
#'     \item{y}{Equatorial y-coordinate in AU}
#'     \item{z}{Equatorial z-coordinate in AU}
#'     \item{vx}{Equatorial x-velocity in AU/day}
#'     \item{vy}{Equatorial y-velocity in AU/day}
#'     \item{vz}{Equatorial z-velocity in AU/day}
#'     \item{t}{The time (POSIXct) at which the state vector is valid}
#'     \item{status}{Status code (0 = success)}
#'   }
#'
#' The position vector components are expressed in Astronomical Units (AU).
#' Multiply by #KM_PER_AU to convert to kilometers. The velocity components
#' are in AU per day.
#'
#' If only position is needed without velocity, [astro_observer_vector()] is slightly
#' more efficient.
#'
#' @export
#' @examples
#' # Get observer state at Sydney Observatory
#' time <- as.POSIXct("2024-01-01 12:00:00", tz = "UTC")
#' obs_state <- astro_observer_state(time, latitude = -33.8688, longitude = 151.2093, height = 0)
#' obs_state
astro_observer_state <- function(
  time,
  latitude,
  longitude,
  height,
  of_date = FALSE
) {
  if (!inherits(time, "POSIXct")) {
    stop("time must be a POSIXct object")
  }
  time_posix <- as.numeric(time)
  res <- astro_observer_state_(time_posix, latitude, longitude, height, of_date)
  res$t <- as.POSIXct(res$t, tz = "UTC")
  res
}

#' Geographic coordinates from observer position vector
#'
#' Given a geocentric equatorial position vector, calculates the geographic
#' latitude, longitude, and elevation of the observer on Earth's surface.
#' This is the inverse function of [astro_observer_vector()].
#'
#' @param vector A list with components representing the observer's position vector:
#'   \describe{
#'     \item{x}{Equatorial x-coordinate in AU}
#'     \item{y}{Equatorial y-coordinate in AU}
#'     \item{z}{Equatorial z-coordinate in AU}
#'     \item{t}{The time (POSIXct) at which the vector is valid}
#'   }
#'   The components are expressed in Astronomical Units (AU).
#'   Divide kilometers by #KM_PER_AU to convert to AU.
#' @param of_date Logical. If `TRUE`, interprets `vector` as equator-of-date coordinates.
#'   If `FALSE` (default), interprets it as J2000 coordinates.
#'
#' @return A list with components:
#'   \describe{
#'     \item{latitude}{Geographic latitude in degrees north of the equator (range: -90 to +90)}
#'     \item{longitude}{Geographic longitude in degrees east of the prime meridian (range: 0 to 360)}
#'     \item{height}{Elevation above sea level in meters}
#'   }
#'
#' @export
#' @examples
#' # Convert a position vector back to geographic coordinates
#' obs_vec <- list(
#'   x = 0.00005, y = 0.00005, z = 0.00005,
#'   t = as.POSIXct("2024-01-01 12:00:00", tz = "UTC")
#' )
#' obs <- astro_vector_observer(obs_vec)
#' obs
astro_vector_observer <- function(vector, of_date = FALSE) {
  astro_vector_observer_(vector, of_date)
}

#' Observer gravitational acceleration
#'
#' Calculates the effective gravitational acceleration experienced by an observer
#' on the Earth's surface. This combines inward gravitational acceleration with
#' outward centrifugal acceleration due to Earth's rotation.
#'
#' This function implements the WGS 84 Ellipsoidal Gravity Formula, which accounts
#' for the Earth's oblate spheroid shape and rotation.
#'
#' @param latitude The geographic latitude of the observer in degrees north of the equator
#'   (range: -90 to +90). By formula symmetry, only the absolute value of latitude matters.
#' @param height The elevation above sea level in meters. Accuracy is best in the range 0 to 100,000 meters.
#'
#' @return The effective gravitational acceleration in meters per second squared (m/s²).
#'
#' The returned value increases toward the Earth's poles and decreases toward the equator,
#' consistent with the weight measured by a spring scale of a fixed mass moved to different
#' latitudes and heights on Earth.
#'
#' @export
#' @examples
#' # Calculate gravity at sea level in different locations
#' gravity_equator <- astro_observer_gravity(latitude = 0, height = 0)
#' gravity_pole <- astro_observer_gravity(latitude = 90, height = 0)
#' gravity_sydney <- astro_observer_gravity(latitude = -33.8688, height = 0)
#'
#' # Gravity is stronger at the poles
#' cat(sprintf("Equator: %.6f m/s²\n", gravity_equator))
#' cat(sprintf("Pole: %.6f m/s²\n", gravity_pole))
#' cat(sprintf("Sydney: %.6f m/s²\n", gravity_sydney))
astro_observer_gravity <- function(latitude, height) {
  astro_observer_gravity_(latitude, height)
}
