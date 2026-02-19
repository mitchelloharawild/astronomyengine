#' Create an astronomical time value
#'
#' Given a UTC calendar date and time, calculates a POSIXct value that can
#' be passed to other Astronomy Engine functions for performing various
#' calculations relating to that date and time.
#'
#' It is the caller's responsibility to ensure that the parameter values are
#' correct. The parameters are not checked for validity, and this function
#' never returns any indication of an error. Invalid values, for example
#' passing in February 31, may cause unexpected return values.
#'
#' @param year Integer UTC calendar year (e.g. 2025).
#' @param month Integer UTC calendar month in the range 1–12.
#' @param day Integer UTC calendar day in the range 1–31.
#' @param hour Integer UTC hour of the day in the range 0–23. Default 0.
#' @param minute Integer UTC minute in the range 0–59. Default 0.
#' @param second Numeric UTC floating-point second in the range [0, 60).
#'   Default 0.
#'
#' @return A `POSIXct` value in UTC that represents the given calendar date
#'   and time.
#' @export
#' @examples
#' astro_make_time(2025, 6, 21)
#' astro_make_time(2025, 6, 21, 12, 30, 0)
astro_make_time <- function(
  year,
  month,
  day,
  hour = 0L,
  minute = 0L,
  second = 0
) {
  posix <- astro_make_time_(
    as.integer(year),
    as.integer(month),
    as.integer(day),
    as.integer(hour),
    as.integer(minute),
    as.double(second)
  )
  structure(posix, class = c("POSIXct", "POSIXt"), tzone = "UTC")
}

#' Current UTC time according to Astronomy Engine
#'
#' Uses the computer's system clock to find the current UTC date and time.
#' Converts that date and time to a POSIXct value and returns the result.
#' Callers can pass this value to other Astronomy Engine functions to calculate
#' current observational conditions.
#'
#' On supported platforms (Linux/Unix, Mac, Windows), the time is measured with
#' microsecond resolution.
#'
#' @return A `POSIXct` value representing the current UTC date and time.
#' @export
#' @examples
#' astro_current_time()
astro_current_time <- function() {
  posix <- astro_current_time_()
  structure(posix, class = c("POSIXct", "POSIXt"), tzone = "UTC")
}
