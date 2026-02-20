#' Search for the next rise or set time of a celestial body
#'
#' Searches for the next time a celestial body rises or sets as seen by an
#' observer on the Earth. Rise time is when the body first starts to be visible
#' above the horizon. Set time is when the body appears to vanish below the
#' horizon. This function adjusts for the apparent angular radius of the
#' observed body (significant only for the Sun and Moon) and corrects for
#' atmospheric refraction.
#'
#' @param body Integer body code (see [astro_body]).
#' @param time A `POSIXct` date/time in UTC to start the search from.
#' @param latitude Observer's geographic latitude in degrees.
#' @param longitude Observer's geographic longitude in degrees.
#' @param height Observer's height above sea level in metres. Default `0`.
#' @param direction `1L` to find the next rise, `-1L` to find the next set.
#'   Default `1L` (rise).
#' @param limit_days Maximum number of days to search. When positive, searches
#'   forward in time; when negative, searches backward. Default `1`.
#' @param meters_above_ground Height of observer above the ground (not sea
#'   level) in metres, for computing the dip of the horizon. Default `0`.
#'
#' @return A `POSIXct` value in UTC, or `NA` if no event is found within
#'   `limit_days`.
#'
#' @details
#' Rise or set may not occur in every 24-hour period. For example, near the
#' Earth's poles, there are long periods where the Sun stays below the horizon,
#' never rising.
#'
#' @export
#' @examples
#' t <- as.POSIXct("2025-06-21", tz = "UTC")
#' # Find next sunrise at Sydney Observatory
#' astro_search_rise_set(astro_body[["SUN"]], t,
#'                       latitude = -33.8688, longitude = 151.2093)
astro_search_rise_set <- function(
  body,
  time,
  latitude,
  longitude,
  height = 0,
  direction = 1L,
  limit_days = 1,
  meters_above_ground = 0
) {
  posix <- astro_search_rise_set_ex_(
    as.integer(body),
    as.double(latitude),
    as.double(longitude),
    as.double(height),
    as.double(time),
    as.integer(direction),
    as.double(limit_days),
    as.double(meters_above_ground)
  )
  if (is.null(posix)) {
    return(NA_real_)
  }
  structure(posix, class = c("POSIXct", "POSIXt"), tzone = attr(time, "tzone"))
}

#' Search for when a body reaches a specified altitude
#'
#' Finds when the center of a given body ascends or descends through a given
#' altitude angle, as seen by an observer at the specified location on the Earth.
#'
#' @param body Integer body code (see [astro_body]).
#' @param time A `POSIXct` date/time in UTC to start the search from.
#' @param latitude Observer's geographic latitude in degrees.
#' @param longitude Observer's geographic longitude in degrees.
#' @param height Observer's height above sea level in metres. Default `0`.
#' @param direction `1L` to find the body ascending, `-1L` to find descending.
#'   Default `1L` (ascending).
#' @param limit_days Maximum number of days to search. When positive, searches
#'   forward in time; when negative, searches backward. Default `1`.
#' @param altitude The desired altitude angle above (positive) or below (negative)
#'   the observer's local horizon, in degrees. Must be in the range \[-90, +90\].
#'
#' @return A `POSIXct` value in UTC, or `NA` if no event is found within
#'   `limit_days`.
#'
#' @details
#' This function is useful for finding twilight times. For example:
#' - Civil dawn: `direction = 1, altitude = -6`
#' - Civil dusk: `direction = -1, altitude = -6`
#' - Nautical twilight: `altitude = -12`
#' - Astronomical twilight: `altitude = -18`
#'
#' @export
#' @examples
#' t <- as.POSIXct("2025-06-21", tz = "UTC")
#' # Find civil dawn (Sun at -6 degrees)
#' astro_search_altitude(astro_body[["SUN"]], t,
#'                       latitude = -33.8688, longitude = 151.2093,
#'                       direction = 1L, altitude = -6)
astro_search_altitude <- function(
  body,
  time,
  latitude,
  longitude,
  height = 0,
  direction = 1L,
  limit_days = 1,
  altitude = 0
) {
  posix <- astro_search_altitude_(
    as.integer(body),
    as.double(latitude),
    as.double(longitude),
    as.double(height),
    as.double(time),
    as.integer(direction),
    as.double(limit_days),
    as.double(altitude)
  )
  if (is.null(posix)) {
    return(NA_real_)
  }
  structure(posix, class = c("POSIXct", "POSIXt"), tzone = attr(time, "tzone"))
}

#' Search for when a body reaches a specified hour angle
#'
#' Searches for the time when the center of a body reaches a specified hour
#' angle as seen by an observer on the Earth. The hour angle is 0 when the body
#' reaches its highest point (culmination) above the horizon in a given day.
#'
#' @param body Integer body code (see [astro_body]).
#' @param time A `POSIXct` date/time in UTC to start the search from.
#' @param latitude Observer's geographic latitude in degrees.
#' @param longitude Observer's geographic longitude in degrees.
#' @param height Observer's height above sea level in metres. Default `0`.
#' @param hour_angle An hour angle value in the range [0, 24) indicating the
#'   number of sidereal hours after the body's most recent culmination.
#'   Default `0` (culmination).
#' @param direction `1L` to search forward in time, `-1L` to search backward.
#'   Default `1L` (forward).
#'
#' @return A list with elements:
#'   \describe{
#'     \item{time}{`POSIXct` time of the event.}
#'     \item{azimuth}{Azimuth angle in degrees (0° = North, 90° = East).}
#'     \item{altitude}{Altitude angle in degrees above the horizon.}
#'   }
#'
#' @details
#' To find when a body culminates (reaches maximum altitude), use `hour_angle = 0`.
#' To find when a body reaches its minimum altitude, use `hour_angle = 12`.
#'
#' @export
#' @examples
#' t <- as.POSIXct("2025-06-21", tz = "UTC")
#' # Find when the Sun culminates (hour_angle = 0)
#' astro_search_hour_angle(astro_body[["SUN"]], t,
#'                         latitude = -33.8688, longitude = 151.2093)
astro_search_hour_angle <- function(
  body,
  time,
  latitude,
  longitude,
  height = 0,
  hour_angle = 0,
  direction = 1L
) {
  result <- astro_search_hour_angle_ex_(
    as.integer(body),
    as.double(latitude),
    as.double(longitude),
    as.double(height),
    as.double(hour_angle),
    as.double(time),
    as.integer(direction)
  )
  result$time <- structure(
    result$time,
    class = c("POSIXct", "POSIXt"),
    tzone = attr(time, "tzone")
  )
  result
}

#' Calculate the hour angle of a body
#'
#' Finds the hour angle of a body for a given observer and time. The hour angle
#' indicates the body's position in the sky with respect to Earth's rotation.
#'
#' @param body Integer body code (see [astro_body]).
#' @param time A `POSIXct` date/time in UTC.
#' @param latitude Observer's geographic latitude in degrees.
#' @param longitude Observer's geographic longitude in degrees.
#' @param height Observer's height above sea level in metres. Default `0`.
#'
#' @return A numeric value representing the hour angle in the range [0, 24),
#'   where each unit is one sidereal hour.
#'
#' @details
#' The hour angle is 0 when the body culminates (reaches its highest point),
#' and increases by 1 unit for every sidereal hour that passes. A value of 12
#' means the body is at its lowest point. A value of 24 is equivalent to 0.
#'
#' @export
#' @examples
#' t <- as.POSIXct("2025-06-21 12:00:00", tz = "UTC")
#' astro_hour_angle(astro_body[["SUN"]], t,
#'                  latitude = -33.8688, longitude = 151.2093)
astro_hour_angle <- function(body, time, latitude, longitude, height = 0) {
  astro_hour_angle_(
    as.integer(body),
    as.double(latitude),
    as.double(longitude),
    as.double(height),
    as.double(time)
  )
}
