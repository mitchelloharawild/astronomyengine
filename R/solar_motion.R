#' Search for Sun longitude
#'
#' Searches for the time when the Sun reaches a specified apparent ecliptic
#' longitude as seen from the center of the Earth.
#'
#' This function can be used to determine equinoxes and solstices. However,
#' for calculating all equinoxes and solstices for a calendar year,
#' [astro_seasons()] is usually more convenient and efficient.
#'
#' The search is performed within the time window from `start_time` to
#' `start_time + limit_days`. It is recommended to keep the search window
#' smaller than 10 days when possible.
#'
#' @param target_lon Numeric. The desired ecliptic longitude in degrees,
#'   relative to the true equinox of date. Must be in the range [0, 360).
#'   Conventional values: 0 = March equinox, 90 = June solstice,
#'   180 = September equinox, 270 = December solstice.
#' @param start_time POSIXct. The date and time for starting the search.
#' @param limit_days Numeric. The number of days to search forward from
#'   `start_time`. Recommended range: 1 to 10 days.
#'
#' @return A list with element:
#'   \describe{
#'     \item{time}{POSIXct value indicating when the Sun reaches the target longitude.}
#'   }
#'
#' @export
#' @examples
#' # Find the March equinox in 2025
#' start <- as.POSIXct("2025-03-15", tz = "UTC")
#' astro_search_sun_longitude(0, start, 10)
astro_search_sun_longitude <- function(target_lon, start_time, limit_days) {
  start_time <- as.POSIXct(start_time, tz = "UTC")
  res <- astro_search_sun_longitude_(
    as.numeric(target_lon),
    as.numeric(start_time),
    as.numeric(limit_days)
  )
  as.POSIXct(res, tz = "UTC")
}

#' Equinoxes and Solstices for a Given Year
#'
#' Calculates the dates and times of both equinoxes and both solstices for a
#' given calendar year.
#'
#' The equinoxes are the moments twice each year when the plane of the
#' Earth's equator passes through the center of the Sun. In other words,
#' the Sun's declination is zero at both equinoxes.
#' The March equinox defines the beginning of spring in the northern hemisphere
#' and the beginning of autumn in the southern hemisphere.
#' The September equinox defines the beginning of autumn in the northern hemisphere
#' and the beginning of spring in the southern hemisphere.
#'
#' The solstices are the moments twice each year when one of the Earth's poles
#' is most tilted toward the Sun. More precisely, the Sun's declination reaches
#' its minimum value at the December solstice, which defines the beginning of
#' winter in the northern hemisphere and the beginning of summer in the southern
#' hemisphere. The Sun's declination reaches its maximum value at the June solstice,
#' which defines the beginning of summer in the northern hemisphere and the beginning
#' of winter in the southern hemisphere.
#'
#' @param year Integer calendar year. While any integer is accepted, only the years
#'   1800 through 2100 have been validated for accuracy. Unit testing against data
#'   from the United States Naval Observatory confirms that all equinoxes and
#'   solstices for this range are within 2 minutes of the correct time.
#'
#' @return A list of `POSIXct` values (in UTC):
#'   \describe{
#'     \item{mar_equinox}{March equinox.}
#'     \item{jun_solstice}{June solstice.}
#'     \item{sep_equinox}{September equinox.}
#'     \item{dec_solstice}{December solstice.}
#'   }
#'
#' @export
#' @examples
#' astro_seasons(2025)
astro_seasons <- function(year) {
  result <- astro_seasons_(as.integer(year))
  lapply(result, as.POSIXct, tz = "UTC")
}
