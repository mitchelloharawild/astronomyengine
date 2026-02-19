#' Heliocentric position vector of a celestial body
#'
#' Calculates the position of a celestial body as a vector using the center of the Sun
#' as the origin. The result is expressed as a Cartesian vector in the J2000 equatorial system
#' (the mean equator of the Earth at noon UTC on 1 January 2000).
#'
#' The position is not corrected for light travel time or aberration.
#'
#' @param body Identifier of celestial body (e.g., `astro_body[["SUN"]]`, `astro_body[["MARS"]]`).
#' @param time A POSIXct time value.
#'
#' @return A list with elements:
#'   \describe{
#'     \item{x}{X coordinate in AU.}
#'     \item{y}{Y coordinate in AU.}
#'     \item{z}{Z coordinate in AU.}
#'     \item{time}{Observation time as POSIXct.}
#'   }
#'
#' @export
#' @examples
#' time <- as.POSIXct("2025-02-19 22:10:12", tz = "UTC")
#' astro_helio_vector(astro_body[["MARS"]], time)
astro_helio_vector <- function(body, time) {
  time <- as.POSIXct(time)
  res <- astro_helio_vector_(body, as.numeric(time))
  res$time <- as.POSIXct(res$time, tz = "UTC")
  res
}

#' Topocentric equatorial coordinates of a celestial body
#'
#' Calculates equatorial coordinates of a celestial body as seen by an observer on Earth's surface.
#'
#' This function corrects for light travel time and topocentric parallax (the angular shift
#' depending on the observer's location on Earth). Parallax correction is most significant for
#' the Moon but has a small effect on other bodies.
#'
#' @param body Identifier of celestial body (e.g., `astro_body[["SUN"]]`, `astro_body[["MARS"]]`).
#'   Must not be the Earth.
#' @param time A POSIXct time value.
#' @param latitude Observer's geographic latitude in degrees (positive north).
#' @param longitude Observer's geographic longitude in degrees (positive east).
#' @param height Observer's height in meters above sea level.
#' @param equdate One of `TRUE` (true-equator-of-date) or `FALSE` (J2000). Default is `FALSE`.
#' @param aberration One of `TRUE` (correct for aberration) or `FALSE`. Default is `TRUE`.
#'
#' @return A list with elements:
#'   \describe{
#'     \item{ra}{Right ascension in sidereal hours.}
#'     \item{dec}{Declination in degrees.}
#'     \item{dist}{Distance in AU.}
#'   }
#'
#' @export
#' @examples
#' time <- as.POSIXct("2025-02-19 22:10:12", tz = "UTC")
#' astro_equator(astro_body[["MARS"]], time, latitude = -33.87, longitude = 151.21)
astro_equator <- function(
  body,
  time,
  latitude,
  longitude,
  height = 0,
  equdate = FALSE,
  aberration = TRUE
) {
  time <- as.POSIXct(time)
  astro_equator_(
    body,
    as.numeric(time),
    as.numeric(latitude),
    as.numeric(longitude),
    as.numeric(height),
    as.logical(equdate),
    as.logical(aberration)
  )
}

#' Sun's position in ecliptic coordinates
#'
#' Calculates the geocentric ecliptic coordinates of the Sun.
#' The returned coordinates are based on the true equinox of date
#' (the instantaneous intersection of the Earth's equatorial plane and
#' the ecliptic plane at the given time).
#'
#' This function accounts for light travel time from the Sun and corrects
#' for precession and nutation of the Earth's axis.
#'
#' @param time A `POSIXct` object representing the date and time.
#'
#' @return A list containing:
#'   \describe{
#'     \item{elon}{Ecliptic longitude in degrees.}
#'     \item{elat}{Ecliptic latitude in degrees.}
#'     \item{vec}{A list with Cartesian coordinates:
#'       \describe{
#'         \item{x}{X-coordinate in AU.}
#'         \item{y}{Y-coordinate in AU.}
#'         \item{z}{Z-coordinate in AU.}
#'         \item{t}{Time as `POSIXct`.}
#'       }
#'     }
#'   }
#'
#' @export
#' @examples
#' time <- as.POSIXct("2025-03-20 09:00:00", tz = "UTC")
#' astro_sun_position(time)
astro_sun_position <- function(time) {
  if (!inherits(time, "POSIXct")) {
    time <- as.POSIXct(time)
  }
  res <- astro_sun_position_(time)
  res$vec$t <- as.POSIXct(res$vec$t, tz = "UTC")
  res
}

#' Convert J2000 equatorial coordinates to ecliptic coordinates
#'
#' Converts equatorial coordinates in the J2000 frame (mean equator of Earth at noon UTC
#' on 1 January 2000) to true ecliptic coordinates of date (relative to the plane of
#' Earth's orbit on the given date).
#'
#' @param x X coordinate in AU.
#' @param y Y coordinate in AU.
#' @param z Z coordinate in AU.
#' @param time A POSIXct time value.
#'
#' @return A list with elements:
#'   \describe{
#'     \item{x}{X coordinate (Cartesian) in ecliptic frame in AU.}
#'     \item{y}{Y coordinate (Cartesian) in ecliptic frame in AU.}
#'     \item{z}{Z coordinate (Cartesian) in ecliptic frame in AU.}
#'     \item{lon}{Ecliptic longitude in degrees.}
#'     \item{lat}{Ecliptic latitude in degrees.}
#'     \item{dist}{Distance in AU.}
#'     \item{time}{Observation time as POSIXct.}
#'   }
#'
#' @export
#' @examples
#' time <- as.POSIXct("2025-02-19 22:10:12", tz = "UTC")
#' astro_ecliptic(1.0, 0.5, 0.2, time)
astro_ecliptic <- function(x, y, z, time) {
  time <- as.POSIXct(time)
  res <- astro_ecliptic_(
    as.numeric(x),
    as.numeric(y),
    as.numeric(z),
    as.numeric(time)
  )
  res$time <- as.POSIXct(res$time, tz = "UTC")
  res
}

#' Heliocentric ecliptic longitude of a body
#'
#' Calculates the angle around the ecliptic plane of a celestial body as seen from
#' the center of the Sun. The angle is measured prograde (in the direction of Earth's
#' orbit) in degrees from the true equinox of date, with values in the range [0, 360).
#'
#' @param body Identifier of celestial body (e.g., `astro_body[["MARS"]]`).
#'   Must not be the Sun.
#' @param time A POSIXct time value.
#'
#' @return A numeric value with the ecliptic longitude in degrees [0, 360).
#'
#' @export
#' @examples
#' time <- as.POSIXct("2025-02-19 22:10:12", tz = "UTC")
#' astro_ecliptic_longitude(astro_body[["MARS"]], time)
astro_ecliptic_longitude <- function(body, time) {
  time <- as.POSIXct(time)
  astro_ecliptic_longitude_(body, as.numeric(time))
}

#' Horizontal coordinates of a celestial body
#'
#' Calculates the apparent location of a body relative to the local horizon of an observer on Earth.
#'
#' Given a date, time, geographic location, and equatorial coordinates of a celestial body,
#' this function returns horizontal coordinates (azimuth and altitude) relative to the horizon.
#'
#' The `ra` and `dec` must be equator-of-date coordinates. Equator-of-date coordinates can be
#' obtained by calling [astro_equator()] with `equdate = "EQUATOR_OF_DATE"` and
#' `aberration = "ABERRATION"`.
#'
#' Atmospheric refraction correction is recommended. Pass `refraction = "REFRACTION_NORMAL"`
#' to correct for optical lensing of the Earth's atmosphere that causes objects to appear
#' higher above the horizon than they actually are.
#'
#' @param time A POSIXct time value.
#' @param latitude Observer's geographic latitude in degrees (positive north).
#' @param longitude Observer's geographic longitude in degrees (positive east).
#' @param ra Right ascension of the body in sidereal hours.
#' @param dec Declination of the body in degrees.
#' @param refraction One of `"REFRACTION_NORMAL"`, `"REFRACTION_JPLHOR"`, or `"REFRACTION_NONE"`.
#'
#' @return A list with elements:
#'   \describe{
#'     \item{azimuth}{Azimuth angle in degrees (eastward from north).}
#'     \item{altitude}{Altitude angle in degrees (positive above horizon).}
#'     \item{ra}{Right ascension of the body in sidereal hours.}
#'     \item{dec}{Declination of the body in degrees.}
#'   }
#'
#' @export
#' @examples
#' time <- as.POSIXct("2025-02-19 22:10:12", tz = "UTC")
#' astro_horizon(time, latitude = -33.87, longitude = 151.21, ra = 10.5, dec = -20.0)
astro_horizon <- function(
  time,
  latitude,
  longitude,
  ra,
  dec,
  refraction = "REFRACTION_NORMAL"
) {
  time <- as.POSIXct(time)
  refraction_code <- switch(
    refraction,
    "REFRACTION_NORMAL" = 0,
    "REFRACTION_JPLHOR" = 1,
    "REFRACTION_NONE" = 2,
    stop("Invalid refraction value")
  )

  astro_horizon_(
    as.numeric(time),
    as.numeric(latitude),
    as.numeric(longitude),
    as.numeric(ra),
    as.numeric(dec),
    refraction_code
  )
}

#' Ecliptic longitude of one body relative to another
#'
#' Determines where one body appears around the ecliptic plane as seen from Earth,
#' relative to another body's apparent position.
#'
#' The returned angle is in the range [0, 360) degrees. The angle is 0 when the two bodies
#' are at the same ecliptic longitude. The angle increases in the prograde direction
#' (the direction planets orbit the Sun). When the angle is 180 degrees, the bodies
#' appear on opposite sides of the sky.
#'
#' Neither `body1` nor `body2` may be the Earth.
#'
#' @param body1 First body (e.g., `astro_body["SUN"]`).
#' @param body2 Second body (e.g., `astro_body["MOON"]`)
#' @param time A POSIXct time value.
#'
#' @return A list with element:
#'   \describe{
#'     \item{angle}{Ecliptic longitude difference in degrees [0, 360).}
#'   }
#'
#' @export
#' @examples
#' time <- as.POSIXct("2025-02-19 22:10:12", tz = "UTC")
#' astro_pair_longitude(astro_body["SUN"], astro_body["MOON"], time)
astro_pair_longitude <- function(body1, body2, time) {
  time <- as.POSIXct(time)
  astro_pair_longitude_(body1, body2, as.numeric(time))
}

#' Geocentric position vector of a celestial body
#'
#' Calculates the position of a celestial body as a vector using the center of the Earth
#' as the origin. The result is expressed as a Cartesian vector in the J2000 equatorial system
#' (the mean equator of the Earth at noon UTC on 1 January 2000).
#'
#' This function corrects for light travel time. The position of the body is back-dated
#' by the amount of time it takes light to travel from that body to an observer on Earth.
#'
#' The position can optionally be corrected for aberration, an effect causing the apparent
#' direction of the body to be shifted due to transverse movement of the Earth.
#'
#' @param body Identifier of celestial body (e.g., `astro_body["MERCURY"]`).
#' @param time A POSIXct time value.
#' @param aberration One of `"ABERRATION"` or `"NO_ABERRATION"`. Default is `"ABERRATION"`.
#'
#' @return A list with elements:
#'   \describe{
#'     \item{x}{X coordinate in AU.}
#'     \item{y}{Y coordinate in AU.}
#'     \item{z}{Z coordinate in AU.}
#'     \item{time}{Observation time as POSIXct.}
#'   }
#'
#' @export
#' @examples
#' time <- as.POSIXct("2025-02-19 22:10:12", tz = "UTC")
#' astro_geo_vector(astro_body["MARS"], time)
astro_geo_vector <- function(body, time, aberration = "ABERRATION") {
  aberration_code <- switch(
    aberration,
    "ABERRATION" = 1,
    "NO_ABERRATION" = 0,
    stop("Invalid aberration value")
  )

  time <- as.POSIXct(time)
  res <- astro_geo_vector_(body, as.numeric(time), aberration_code)
  res$time <- as.POSIXct(res$time, tz = "UTC")
  res
}

#' Barycentric position and velocity vectors
#'
#' Calculates the barycentric (solar system barycenter) position and velocity vectors
#' for a given celestial body at a specified time.
#'
#' The vectors are expressed in J2000 mean equator coordinates (the mean equator of the
#' Earth at noon UTC on 1 January 2000).
#'
#' @param body Identifier of celestial body (e.g., `astro_body["MERCURY"]`).
#' @param time A POSIXct time value.
#'
#' @return A list with elements:
#'   \describe{
#'     \item{x}{X position in AU.}
#'     \item{y}{Y position in AU.}
#'     \item{z}{Z position in AU.}
#'     \item{vx}{X velocity in AU/day.}
#'     \item{vy}{Y velocity in AU/day.}
#'     \item{vz}{Z velocity in AU/day.}
#'     \item{time}{Observation time as POSIXct.}
#'   }
#'
#' @export
#' @examples
#' time <- as.POSIXct("2025-02-19 22:10:12", tz = "UTC")
#' astro_bary_state(astro_body["MARS"], time)
astro_bary_state <- function(body, time) {
  time <- as.POSIXct(time)
  res <- astro_bary_state_(body, as.numeric(time))
  res$time <- as.POSIXct(res$time, tz = "UTC")
  res
}
