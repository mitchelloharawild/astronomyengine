#' Search for the next planetary apsis
#'
#' Finds the date and time of a planet's perihelion (closest approach to the Sun)
#' or aphelion (farthest distance from the Sun) after a given time.
#'
#' The closest point is called perihelion and the farthest point is called aphelion.
#' To iterate through consecutive alternating perihelion and aphelion events,
#' call `search_planet_apsis()` once, then use the return value to call
#' `next_planet_apsis()`. After that, keep feeding the previous return value
#' into another call of `next_planet_apsis()` as many times as desired.
#'
#' @param body Integer constant identifying the planet. Use `astro_body["PLANET_NAME"]`
#'   where `PLANET_NAME` is one of: `"MERCURY"`, `"VENUS"`, `"EARTH"`, `"MARS"`,
#'   `"JUPITER"`, `"SATURN"`, `"URANUS"`, `"NEPTUNE"`, or `"PLUTO"`.
#'   Not allowed to be `"SUN"` or `"MOON"`.
#'
#' @param start_time A `POSIXct` value indicating the date and time at which to
#'   start searching for the next perihelion or aphelion.
#'
#' @return A list containing:
#'   \describe{
#'     \item{kind}{An integer flag: 0 for perihelion, 1 for aphelion.}
#'     \item{time}{A `POSIXct` value representing the date and time of the
#'       next planetary apsis.}
#'     \item{dist_au}{The distance from the planet to the Sun in astronomical units.}
#'     \item{dist_km}{The distance from the planet to the Sun in kilometers.}
#'   }
#'
#' @seealso [next_planet_apsis()]
#'
#' @export
#' @examples
#' # Find the next perihelion/aphelion of Mars after 2025-01-01
#' start <- as.POSIXct("2025-01-01", tz = "UTC")
#' apsis <- search_planet_apsis(astro_body["MARS"], start)
#' apsis
search_planet_apsis <- function(body, start_time) {
  input_tz <- attr(start_time, "tzone")
  start_time <- as.POSIXct(start_time, tz = input_tz)
  result <- search_planet_apsis_(as.integer(body), as.numeric(start_time))
  result$time <- as.POSIXct(result$time, tz = input_tz)
  result
}

#' Find the next planetary apsis in a series
#'
#' Given an aphelion event, this function finds the next perihelion event,
#' and vice versa. This requires an apsis event obtained from a call to
#' `search_planet_apsis()` or a previous call to `next_planet_apsis()`.
#'
#' @param body Integer constant identifying the planet. Use `astro_body["PLANET_NAME"]`
#'   where `PLANET_NAME` is one of: `"MERCURY"`, `"VENUS"`, `"EARTH"`, `"MARS"`,
#'   `"JUPITER"`, `"SATURN"`, `"URANUS"`, `"NEPTUNE"`, or `"PLUTO"`.
#'   Must match the body passed into the call that produced the `apsis` parameter.
#'   Not allowed to be `"SUN"` or `"MOON"`.
#'
#' @param apsis An apsis event (a list) obtained from a call to
#'   `search_planet_apsis()` or `next_planet_apsis()`.
#'
#' @return A list with the same structure as returned by `search_planet_apsis()`:
#'   \describe{
#'     \item{kind}{An integer flag: 0 for perihelion, 1 for aphelion.}
#'     \item{time}{A `POSIXct` value representing the date and time of the
#'       next planetary apsis.}
#'     \item{dist_au}{The distance from the planet to the Sun in astronomical units.}
#'     \item{dist_km}{The distance from the planet to the Sun in kilometers.}
#'   }
#'
#' @seealso [search_planet_apsis()]
#'
#' @export
#' @examples
#' # Find successive apsis events for Mars
#' start <- as.POSIXct("2025-01-01", tz = "UTC")
#' apsis1 <- search_planet_apsis(astro_body["MARS"], start)
#' apsis2 <- next_planet_apsis(astro_body["MARS"], apsis1)
#' apsis3 <- next_planet_apsis(astro_body["MARS"], apsis2)
next_planet_apsis <- function(body, apsis) {
  result <- next_planet_apsis_(as.integer(body), apsis)
  result$time <- as.POSIXct(result$time, tz = attr(apsis$time, "tzone"))
  result
}

#' Search for lunar apsis events
#'
#' Finds the date and time of the Moon's closest distance (perigee) or farthest
#' distance (apogee) with respect to the Earth after a given start time.
#'
#' The closest point is called *perigee* and the farthest point is called *apogee*.
#' The word *apsis* refers to either event.
#'
#' To iterate through consecutive alternating perigee and apogee events, call
#' `search_lunar_apsis()` once, then use the return value to call
#' `next_lunar_apsis()`. After that, keep feeding the previous return value from
#' `next_lunar_apsis()` into another call of `next_lunar_apsis()` as many times
#' as desired.
#'
#' @param start_time A `POSIXct` datetime object indicating when to start the search.
#'
#' @return A list containing:
#'   \describe{
#'     \item{time}{A `POSIXct` datetime of the next lunar apsis.}
#'     \item{kind}{Integer code: 0 for perigee (APSIS_PERICENTER), 1 for apogee (APSIS_APOCENTER).}
#'     \item{dist_au}{Distance in astronomical units.}
#'     \item{dist_km}{Distance in kilometers.}
#'   }
#'
#' @export
#' @examples
#' start <- as.POSIXct("2025-01-01", tz = "UTC")
#' apsis <- search_lunar_apsis(start)
#' apsis$time
#' apsis$kind
search_lunar_apsis <- function(start_time) {
  input_tz <- attr(start_time, "tzone")
  start_time <- as.POSIXct(start_time, tz = input_tz)
  res <- search_lunar_apsis_(as.numeric(start_time))
  res$time <- as.POSIXct(res$time, tz = input_tz)
  res
}

#' Find the next lunar apsis event
#'
#' Given a lunar apsis event (perigee or apogee), finds the next apsis event
#' in the series. This function alternates between finding perigees and apogees.
#'
#' @param apsis A list returned from `search_lunar_apsis()` or a previous call
#'   to `next_lunar_apsis()`.
#'
#' @return A list with the same structure as `search_lunar_apsis()`:
#'   \describe{
#'     \item{time}{A `POSIXct` datetime of the next lunar apsis.}
#'     \item{kind}{Integer code: 0 for perigee, 1 for apogee.}
#'     \item{dist_au}{Distance in astronomical units.}
#'     \item{dist_km}{Distance in kilometers.}
#'   }
#'
#' @export
#' @examples
#' start <- as.POSIXct("2025-01-01", tz = "UTC")
#' apsis1 <- search_lunar_apsis(start)
#' apsis2 <- next_lunar_apsis(apsis1)
#' apsis3 <- next_lunar_apsis(apsis2)
next_lunar_apsis <- function(apsis) {
  # Ensure apsis has required structure
  if (
    !is.list(apsis) ||
      !all(c("time", "kind", "dist_au", "dist_km") %in% names(apsis))
  ) {
    stop(
      "apsis must be a list returned from search_lunar_apsis() or next_lunar_apsis()"
    )
  }

  # Convert time back to numeric for C function
  apsis_list <- list(
    status = 0L,
    kind = as.integer(apsis$kind),
    time = as.numeric(apsis$time),
    psi = 0.0,
    eps = 0.0,
    ref_epoch = 2000.0,
    dist_au = apsis$dist_au,
    dist_km = apsis$dist_km
  )

  result <- next_lunar_apsis_(apsis_list)
  result$time <- as.POSIXct(result$time, origin = "1970-01-01", tz = attr(apsis$time, "tzone"))
  result
}
