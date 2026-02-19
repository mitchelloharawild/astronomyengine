#' Illumination data for a celestial body
#'
#' Calculates visual magnitude, phase angle, and related illumination information
#' for a celestial body as seen from Earth.
#'
#' Visual magnitude is a measure of brightness, where smaller (or negative) values
#' indicate brighter objects and larger values indicate dimmer objects.
#'
#' Phase angle is the angle in degrees between the Sun and Earth as seen from the
#' body's center. It indicates what fraction of the body appears illuminated from Earth:
#' - Phase angle near 0° means the body appears "full"
#' - Phase angle near 90° means the body appears "half full"
#' - Phase angle near 180° means the body appears as a thin crescent
#'
#' For Saturn, the returned list includes `ring_tilt`, which is the tilt angle
#' in degrees of Saturn's rings as seen from Earth (0° means edge-on and nearly invisible).
#'
#' @param body An integer representing a celestial body (see `[astro_body]`).
#'   Cannot be Earth.
#'
#' @param time A `POSIXct` datetime object.
#'
#' @return A list containing:
#'   \describe{
#'     \item{time}{The input time as a `POSIXct` object.}
#'     \item{mag}{Visual magnitude (numeric).}
#'     \item{phase_angle}{Phase angle in degrees (numeric).}
#'     \item{phase_fraction}{Fraction of the body illuminated from 0 to 1 (numeric).}
#'     \item{helio_dist}{Distance from Sun in AU (numeric).}
#'     \item{ring_tilt}{Saturn's ring tilt in degrees, 0 for other bodies (numeric).}
#'   }
#'
#' @export
#' @examples
#' # Get illumination data for Mars on 2025-06-21
#' time <- as.POSIXct("2025-06-21", tz = "UTC")
#' astro_illumination(astro_body["MARS"], time)
astro_illumination <- function(body, time) {
  if (!inherits(time, "POSIXct")) {
    stop("`time` must be a POSIXct datetime object")
  }

  res <- astro_illumination_(
    as.integer(body),
    as.numeric(time)
  )
  res$time <- as.POSIXct(res$time, tz = "UTC")
  res
}

#' Search for peak magnitude of Venus
#'
#' Searches for the next date and time when Venus will appear brightest as seen
#' from Earth. This function currently only supports Venus.
#'
#' Venus reaches peak magnitude (maximum brightness) at certain times in its orbit.
#' This is distinct from other brightness events: Mercury's peak magnitude occurs
#' at superior conjunction when it's invisible, and outer planets reach peak magnitude
#' at opposition.
#'
#' @param body An integer representing the celestial body. Currently only
#'   `astro_body["VENUS"]` is supported. Returns error for other bodies.
#'
#' @param start_time A `POSIXct` datetime object specifying when to begin
#'   the search.
#'
#' @return A list containing:
#'   \describe{
#'     \item{time}{The time of peak magnitude as a `POSIXct` object.}
#'     \item{mag}{Visual magnitude at peak brightness (numeric).}
#'     \item{phase_angle}{Phase angle in degrees (numeric).}
#'     \item{phase_fraction}{Fraction of Venus illuminated (numeric).}
#'     \item{helio_dist}{Distance from Sun in AU (numeric).}
#'     \item{ring_tilt}{Always 0 for Venus (numeric).}
#'   }
#'
#' @details
#' The search may require iterating through multiple synodic periods of Venus
#' to find an event after the specified start time. The function will search
#' forward from the start time until it finds a valid peak magnitude event.
#'
#' @export
#' @examples
#' # Find when Venus will next reach peak magnitude after 2025-01-01
#' start <- as.POSIXct("2025-01-01", tz = "UTC")
#' astro_search_peak_magnitude(astro_body["VENUS"], start)
astro_search_peak_magnitude <- function(body, start_time) {
  if (!inherits(start_time, "POSIXct")) {
    stop("`start_time` must be a POSIXct datetime object")
  }

  res <- astro_search_peak_magnitude_(
    as.integer(body),
    as.numeric(start_time)
  )
  res$time <- as.POSIXct(res$time, tz = "UTC")
  res
}

#' Angle from the Sun
#'
#' Returns the angle between a celestial body and the Sun, as seen from the
#' center of the Earth. This angle helps determine how easy it is to see the
#' body away from the glare of the Sun.
#'
#' @param body Integer code identifying the celestial body. Must not be Earth.
#' @param time A POSIXct date-time value indicating the observation time.
#'
#' @return A list with the following elements:
#'   \describe{
#'     \item{angle}{The angle in degrees between the Sun and the body as seen
#'       from the center of the Earth.}
#'     \item{status}{Status code from the underlying C function.}
#'   }
#' @export
#' @examples
#' time <- as.POSIXct("2025-06-15 12:00:00", tz = "UTC")
#' astro_angle_from_sun(body = astro_body["MERCURY"], time = time)
astro_angle_from_sun <- function(body, time) {
  astro_angle_from_sun_(
    as.integer(body),
    as.numeric(time)
  )
}

#' Elongation of a celestial body
#'
#' Determines visibility of a celestial body relative to the Sun, as seen from
#' the Earth. Returns information about the elongation angle and whether the
#' body is best observed in the morning or evening.
#'
#' @param body Integer code identifying the celestial body.
#' @param time A POSIXct date-time value indicating the observation time.
#'
#' @return A list with the following elements:
#'   \describe{
#'     \item{visibility}{Integer flag indicating morning (0) or evening (1)
#'       visibility.}
#'     \item{elongation}{The angle in degrees between the Earth-Sun and
#'       Earth-body vectors. Range: \[0, 180\].}
#'     \item{ecliptic_separation}{The absolute difference in ecliptic longitude
#'       between the body and the Sun. Range: \[0, 180\].}
#'     \item{time}{A POSIXct value representing the observation time.}
#'     \item{status}{Status code from the underlying C function.}
#'   }
#' @export
#' @examples
#' time <- as.POSIXct("2025-06-15 12:00:00", tz = "UTC")
#' astro_elongation(body = astro_body["MERCURY"], time = time)
astro_elongation <- function(body, time) {
  res <- astro_elongation_(
    as.integer(body),
    as.numeric(time)
  )

  res$time <- as.POSIXct(res$time, tz = "UTC")
  res
}

#' Search for maximum elongation
#'
#' Finds the next date and time when Mercury or Venus reaches its maximum angle
#' from the Sun as seen from the Earth. Maximum elongation events are the best
#' opportunities for observing these inner planets.
#'
#' @param body Integer code for the celestial body. Must be Mercury (3) or
#'   Venus (2). Other values will fail.
#' @param start_time A POSIXct date-time value indicating the search start time.
#'   The maximum elongation event found will be the first one occurring after
#'   this time.
#'
#' @return A list with the following elements:
#'   \describe{
#'     \item{visibility}{Integer flag indicating morning (0) or evening (1)
#'       visibility.}
#'     \item{elongation}{The maximum elongation angle in degrees.}
#'     \item{ecliptic_separation}{The ecliptic separation at maximum elongation.}
#'     \item{time}{A POSIXct value representing the time of maximum elongation.}
#'     \item{status}{Status code from the underlying C function.}
#'   }
#' @export
#' @examples
#' start <- as.POSIXct("2025-01-01 00:00:00", tz = "UTC")
#' astro_search_max_elongation(body = astro_body["MERCURY"], start_time = start)
astro_search_max_elongation <- function(body, start_time) {
  res <- astro_search_max_elongation_(
    as.integer(body),
    as.numeric(start_time)
  )

  res$time <- as.POSIXct(res$time, tz = "UTC")
  res
}
