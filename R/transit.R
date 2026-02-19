#' Search for a lunar eclipse
#'
#' Searches for the first lunar eclipse that occurs after the given start time.
#' A lunar eclipse may be penumbral, partial, or total.
#'
#' @param start_time A `POSIXct` date and time for starting the search.
#'
#' @return A list with the following elements:
#'   \describe{
#'     \item{kind}{Integer code for eclipse type (0=penumbral, 1=partial, 2=total).}
#'     \item{obscuration}{Fraction of Moon's disc covered by Earth's umbra (0-1).}
#'     \item{peak}{POSIXct time of eclipse peak.}
#'     \item{sd_total}{Semi-duration of total phase in minutes.}
#'     \item{sd_partial}{Semi-duration of partial phase in minutes.}
#'     \item{sd_penum}{Semi-duration of penumbral phase in minutes.}
#'   }
#' @export
#' @examples
#' start <- as.POSIXct("2025-01-01", tz = "UTC")
#' astro_search_lunar_eclipse(start)
astro_search_lunar_eclipse <- function(start_time) {
  start_time <- as.POSIXct(start_time, tz = "UTC")
  res <- astro_search_lunar_eclipse_(as.numeric(start_time))
  res$peak <- as.POSIXct(res$peak, tz = "UTC")
  res
}

#' Find the next lunar eclipse in a series
#'
#' After using [astro_search_lunar_eclipse()] to find the first lunar eclipse,
#' call this function to find the next consecutive lunar eclipse.
#' Pass in the `peak` value from the previous call.
#'
#' @param prev_eclipse_time A `POSIXct` time near a lunar eclipse peak
#'   (typically from a previous call).
#'
#' @return A list with the following elements:
#'   \describe{
#'     \item{kind}{Integer code for eclipse type (0=penumbral, 1=partial, 2=total).}
#'     \item{obscuration}{Fraction of Moon's disc covered by Earth's umbra (0-1).}
#'     \item{peak}{POSIXct time of eclipse peak.}
#'     \item{sd_total}{Semi-duration of total phase in minutes.}
#'     \item{sd_partial}{Semi-duration of partial phase in minutes.}
#'     \item{sd_penum}{Semi-duration of penumbral phase in minutes.}
#'   }
#' @export
#' @examples
#' start <- as.POSIXct("2025-01-01", tz = "UTC")
#' first_eclipse <- astro_search_lunar_eclipse(start)
#' next_eclipse <- astro_next_lunar_eclipse(first_eclipse$peak)
astro_next_lunar_eclipse <- function(prev_eclipse_time) {
  prev_eclipse_time <- as.POSIXct(prev_eclipse_time, tz = "UTC")
  res <- astro_next_lunar_eclipse_(as.numeric(prev_eclipse_time))
  res$peak <- as.POSIXct(res$peak, tz = "UTC")
  res
}

#' Search for a global solar eclipse
#'
#' Searches for the first solar eclipse visible anywhere on Earth's surface
#' that occurs after the given start time. A solar eclipse may be partial,
#' annular, or total. To find a series of eclipses, use \code{next_global_solar_eclipse}
#' with the \code{peak} time from the previous result.
#'
#' @param start_time A \code{POSIXct} date/time for starting the search.
#'
#' @return A list containing:
#'   \describe{
#'     \item{status}{Status code (0 = success).}
#'     \item{kind}{Type of eclipse: 0 = partial, 1 = annular, 2 = total.}
#'     \item{peak}{Peak time of the eclipse as \code{POSIXct}.}
#'     \item{distance}{Distance in kilometers from Earth's center to Moon's shadow axis.}
#'     \item{latitude}{Latitude of peak eclipse.}
#'     \item{longitude}{Longitude of peak eclipse.}
#'   }
#' @export
#' @examples
#' start <- as.POSIXct("2025-01-01", tz = "UTC")
#' search_global_solar_eclipse(start)
search_global_solar_eclipse <- function(start_time) {
  start_time <- as.POSIXct(start_time, tz = "UTC")
  res <- search_global_solar_eclipse_(as.numeric(start_time))
  res$peak <- as.POSIXct(res$peak, tz = "UTC")
  res
}

#' Search for the next global solar eclipse
#'
#' Finds the next solar eclipse in a series after the given eclipse time.
#' Typically, you pass the \code{peak} value from a previous
#' \code{search_global_solar_eclipse} or \code{next_global_solar_eclipse} call.
#'
#' @param prev_eclipse_time A \code{POSIXct} time near a previous eclipse peak.
#'
#' @return A list with the same structure as \code{search_global_solar_eclipse}.
#'
#' @export
#' @examples
#' start <- as.POSIXct("2025-01-01", tz = "UTC")
#' eclipse1 <- search_global_solar_eclipse(start)
#' eclipse2 <- next_global_solar_eclipse(eclipse1$peak)
next_global_solar_eclipse <- function(prev_eclipse_time) {
  prev_eclipse_time <- as.POSIXct(prev_eclipse_time, tz = "UTC")
  res <- next_global_solar_eclipse_(as.numeric(prev_eclipse_time))
  res$peak <- as.POSIXct(res$peak, tz = "UTC")
  res
}

#' Search for a local solar eclipse
#'
#' Searches for the first solar eclipse visible at a specific location on Earth's
#' surface that occurs after the given start time. Note: an eclipse reported by
#' this function might be partly or completely invisible due to the time of day.
#' To find a series of eclipses, use \code{next_local_solar_eclipse} with the
#' \code{peak} time from the previous result.
#'
#' @param start_time A \code{POSIXct} date/time for starting the search.
#' @param latitude Latitude of the observer in degrees (-90 to 90).
#' @param longitude Longitude of the observer in degrees (-180 to 180).
#'
#' @return A list containing:
#'   \describe{
#'     \item{status}{Status code (0 = success).}
#'     \item{kind}{Type of eclipse: 0 = partial, 1 = annular, 2 = total.}
#'     \item{partial_begin}{Start of partial eclipse (list with \code{time} and \code{altitude}).}
#'     \item{total_begin}{Start of total/annular eclipse (list with \code{time} and \code{altitude}).}
#'     \item{peak}{Peak of eclipse (list with \code{time} and \code{altitude}).}
#'     \item{total_end}{End of total/annular eclipse (list with \code{time} and \code{altitude}).}
#'     \item{partial_end}{End of partial eclipse (list with \code{time} and \code{altitude}).}
#'   }
#' @export
#' @examples
#' start <- as.POSIXct("2025-01-01", tz = "UTC")
#' eclipse <- search_local_solar_eclipse(start, latitude = 37.77, longitude = -122.41)
search_local_solar_eclipse <- function(start_time, latitude, longitude) {
  start_time <- as.POSIXct(start_time, tz = "UTC")
  res <- search_local_solar_eclipse_(
    as.numeric(start_time),
    latitude,
    longitude
  )

  # Convert time values in each eclipse phase
  res$partial_begin$time <- as.POSIXct(
    res$partial_begin$time,
    tz = "UTC",
    origin = "1970-01-01"
  )
  res$total_begin$time <- as.POSIXct(
    res$total_begin$time,
    tz = "UTC",
    origin = "1970-01-01"
  )
  res$peak$time <- as.POSIXct(res$peak$time, tz = "UTC", origin = "1970-01-01")
  res$total_end$time <- as.POSIXct(
    res$total_end$time,
    tz = "UTC",
    origin = "1970-01-01"
  )
  res$partial_end$time <- as.POSIXct(
    res$partial_end$time,
    tz = "UTC",
    origin = "1970-01-01"
  )

  res
}

#' Search for the next local solar eclipse
#'
#' Finds the next solar eclipse in a series at a specific location.
#' Typically, you pass the \code{peak} value from a previous
#' \code{search_local_solar_eclipse} or \code{next_local_solar_eclipse} call.
#'
#' @param prev_eclipse_time A \code{POSIXct} time near a previous eclipse peak.
#' @param latitude Latitude of the observer in degrees (-90 to 90).
#' @param longitude Longitude of the observer in degrees (-180 to 180).
#'
#' @return A list with the same structure as \code{search_local_solar_eclipse}.
#'
#' @export
#' @examples
#' start <- as.POSIXct("2025-01-01", tz = "UTC")
#' eclipse1 <- search_local_solar_eclipse(start, 37.77, -122.41)
#' eclipse2 <- next_local_solar_eclipse(eclipse1$peak$time, 37.77, -122.41)
next_local_solar_eclipse <- function(prev_eclipse_time, latitude, longitude) {
  prev_eclipse_time <- as.POSIXct(prev_eclipse_time, tz = "UTC")
  res <- next_local_solar_eclipse_(
    as.numeric(prev_eclipse_time),
    latitude,
    longitude
  )

  # Convert time values in each eclipse phase
  res$partial_begin$time <- as.POSIXct(
    res$partial_begin$time,
    tz = "UTC",
    origin = "1970-01-01"
  )
  res$total_begin$time <- as.POSIXct(
    res$total_begin$time,
    tz = "UTC",
    origin = "1970-01-01"
  )
  res$peak$time <- as.POSIXct(res$peak$time, tz = "UTC", origin = "1970-01-01")
  res$total_end$time <- as.POSIXct(
    res$total_end$time,
    tz = "UTC",
    origin = "1970-01-01"
  )
  res$partial_end$time <- as.POSIXct(
    res$partial_end$time,
    tz = "UTC",
    origin = "1970-01-01"
  )

  res
}

#' Search for a transit of Mercury or Venus
#'
#' Finds the first transit of Mercury or Venus after a specified date.
#' A transit occurs when an inferior planet passes between the Sun and Earth,
#' with the planet's silhouette visible against the Sun.
#'
#' @param body Integer code for the planet. Use `1` for Mercury or `2` for Venus.
#' @param start_time A `POSIXct` datetime for starting the search.
#'
#' @return A list with elements:
#'   \describe{
#'     \item{start}{Start time of the transit (POSIXct).}
#'     \item{peak}{Time of closest approach (POSIXct).}
#'     \item{finish}{End time of the transit (POSIXct).}
#'     \item{separation}{Angular separation at peak in arcminutes.}
#'   }
#'
#' @export
#' @examples
#' start <- as.POSIXct("2025-01-01", tz = "UTC")
#' astro_search_transit(astro_body["MERCURY"], start)
astro_search_transit <- function(body, start_time) {
  res <- astro_search_transit_(
    as.integer(body),
    as.numeric(start_time)
  )
  res[c("start", "peak", "finish")] <- lapply(
    res[c("start", "peak", "finish")],
    as.POSIXct,
    tz = "UTC"
  )
  res
}

#' Search for the next transit of Mercury or Venus
#'
#' Finds the next transit of Mercury or Venus after a previous transit.
#' Call this repeatedly to find successive transits.
#'
#' @param body Integer code for the planet. Use `1` for Mercury or `2` for Venus.
#' @param prev_transit_time A `POSIXct` datetime from a previous transit result.
#'
#' @return A list with elements:
#'   \describe{
#'     \item{start}{Start time of the transit (POSIXct).}
#'     \item{peak}{Time of closest approach (POSIXct).}
#'     \item{finish}{End time of the transit (POSIXct).}
#'     \item{separation}{Angular separation at peak in arcminutes.}
#'   }
#'
#' @export
#' @examples
#' start <- as.POSIXct("2025-01-01", tz = "UTC")
#' transit1 <- astro_search_transit(astro_body["MERCURY"], start)
#' transit2 <- astro_next_transit(astro_body["MERCURY"], transit1$peak)
astro_next_transit <- function(body, prev_transit_time) {
  res <- astro_next_transit_(
    as.integer(body),
    as.numeric(prev_transit_time)
  )
  res[c("start", "peak", "finish")] <- lapply(
    res[c("start", "peak", "finish")],
    as.POSIXct,
    tz = "UTC"
  )
  res
}
