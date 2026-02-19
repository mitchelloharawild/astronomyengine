#' Moon Phase Angle
#'
#' Returns the Moon's phase as an angle from 0 to 360 degrees, where 0 is new moon,
#' 90 is first quarter, 180 is full moon, and 270 is third quarter.
#'
#' @param time A POSIXct datetime representing the observation time.
#'
#' @return A numeric value representing the Moon's phase angle in degrees (0-360).
#'
#' @export
#' @examples
#' astro_moon_phase(as.POSIXct("2025-02-19 12:00:00", tz = "UTC"))
astro_moon_phase <- function(time) {
  astro_moon_phase_(as.numeric(time))
}

#' Search for a Specific Moon Phase
#'
#' Searches for the time when the Moon reaches a specified phase angle.
#'
#' @param target_lon A numeric value in the range [0, 360) representing the
#'   target phase angle. Common values: 0 = new moon, 90 = first quarter,
#'   180 = full moon, 270 = third quarter.
#'
#' @param start_time A POSIXct datetime to begin the search.
#'
#' @param limit_days A numeric value specifying the search window in days.
#'   Positive values search forward, negative values search backward.
#'
#' @return A POSIXct datetime when the Moon reaches the target phase.
#'
#' @export
#' @examples
#' start <- as.POSIXct("2025-02-19", tz = "UTC")
#' astro_search_moon_phase(0, start, 30)  # Find next new moon
astro_search_moon_phase <- function(target_lon, start_time, limit_days) {
  result <- astro_search_moon_phase_(target_lon, start_time, limit_days)
  as.POSIXct(result, origin = "1970-01-01", tz = "UTC")
}

#' Find First Lunar Quarter
#'
#' Finds the first lunar quarter (new moon, first quarter, full moon, or
#' third quarter) after the specified date and time.
#'
#' @param start_time A POSIXct datetime to begin the search.
#'
#' @return A list with:
#'   \describe{
#'     \item{quarter}{Integer 0-3: 0 = new moon, 1 = first quarter, 2 = full moon, 3 = third quarter.}
#'     \item{time}{POSIXct datetime of the lunar quarter.}
#'   }
#'
#' @export
#' @examples
#' start <- as.POSIXct("2025-02-19", tz = "UTC")
#' astro_search_moon_quarter(start)
astro_search_moon_quarter <- function(start_time) {
  result <- astro_search_moon_quarter_(start_time)
  result$time <- as.POSIXct(result$time, origin = "1970-01-01", tz = "UTC")
  result
}

#' Find Next Lunar Quarter
#'
#' Continues searching for lunar quarters from a previous search result.
#' Call this function repeatedly after [astro_search_moon_quarter()] to
#' find consecutive lunar quarters.
#'
#' @param mq A list returned by [astro_search_moon_quarter()] or a previous
#'   call to `astro_next_moon_quarter()`.
#'
#' @return A list with:
#'   \describe{
#'     \item{quarter}{Integer 0-3: 0 = new moon, 1 = first quarter, 2 = full moon, 3 = third quarter.}
#'     \item{time}{POSIXct datetime of the next lunar quarter.}
#'   }
#'
#' @export
#' @examples
#' start <- as.POSIXct("2025-02-19", tz = "UTC")
#' q1 <- astro_search_moon_quarter(start)
#' q2 <- astro_next_moon_quarter(q1)
#' q3 <- astro_next_moon_quarter(q2)
astro_next_moon_quarter <- function(mq) {
  if (!is.list(mq) || !("quarter" %in% names(mq)) || !("time" %in% names(mq))) {
    stop("mq must be a list with 'quarter' and 'time' fields")
  }

  result <- astro_next_moon_quarter_(mq$quarter, mq$time)
  result$time <- as.POSIXct(result$time, origin = "1970-01-01", tz = "UTC")
  result
}
