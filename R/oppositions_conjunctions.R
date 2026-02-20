#' Search for relative longitude event between Earth and another planet
#'
#' Searches for the next time when the relative longitude (angle measured in
#' the ecliptic plane from one planet to another as seen from the Sun) reaches
#' a specified target angle.
#'
#' Relative longitude defines several important astronomical events:
#' \describe{
#'   \item{0°}{Conjunction (inferior for Mercury/Venus, opposition for outer planets)}
#'   \item{180°}{Superior conjunction (planet on opposite side of Sun from Earth)}
#' }
#'
#' @param body An integer representing a planet other than Earth (see `[astro_body]`).
#'   Cannot be the Earth, Moon, or Sun.
#'
#' @param target_rel_lon Numeric. The desired relative longitude in degrees.
#'   Must be in the range [0, 360).
#'
#' @param start_time A `POSIXct` datetime object specifying when to begin
#'   the search.
#'
#' @return A `POSIXct` datetime object indicating when the target relative
#'   longitude is reached.
#'
#' @details
#' For planets orbiting closer to the Sun than Earth (Mercury, Venus),
#' a relative longitude of 0° indicates inferior conjunction.
#' For planets orbiting farther from the Sun, 0° indicates opposition (closest approach).
#'
#' @export
#' @examples
#' # Find next opposition of Mars after 2025-01-01
#' start <- as.POSIXct("2025-01-01", tz = "UTC")
#' astro_search_relative_longitude(astro_body["MARS"], 0, start)
astro_search_relative_longitude <- function(body, target_rel_lon, start_time) {
  if (!inherits(start_time, "POSIXct")) {
    stop("`start_time` must be a POSIXct datetime object")
  }

  res <- astro_search_relative_longitude_(
    body,
    as.numeric(target_rel_lon),
    start_time
  )

  as.POSIXct(res, tz = attr(start_time, "tzone"))
}
