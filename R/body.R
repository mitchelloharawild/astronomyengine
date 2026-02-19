#' Celestial body codes
#'
#' Integer codes used by Astronomy Engine to identify celestial bodies.
#' Pass these constants (or their integer values) to functions that accept
#' a `body` argument.
#'
#' @format An integer vector with named elements:
#' \describe{
#'   \item{MERCURY}{0}
#'   \item{VENUS}{1}
#'   \item{EARTH}{2}
#'   \item{MARS}{3}
#'   \item{JUPITER}{4}
#'   \item{SATURN}{5}
#'   \item{URANUS}{6}
#'   \item{NEPTUNE}{7}
#'   \item{PLUTO}{8}
#'   \item{SUN}{9}
#'   \item{MOON}{10}
#'   \item{EMB}{11 — Earth/Moon Barycenter}
#'   \item{SSB}{12 — Solar System Barycenter}
#' }
#' @export
#' @examples
#' astro_body["SUN"]
#' astro_body["MARS"]
astro_body <- c(
  MERCURY = 0L,
  VENUS = 1L,
  EARTH = 2L,
  MARS = 3L,
  JUPITER = 4L,
  SATURN = 5L,
  URANUS = 6L,
  NEPTUNE = 7L,
  PLUTO = 8L,
  SUN = 9L,
  MOON = 10L,
  EMB = 11L,
  SSB = 12L
)

#' Get the name of a celestial body
#'
#' Finds the name of a celestial body.
#'
#' @param body The celestial body whose name is to be found.
#' @return The English-language name of the celestial body, or `""` if the body is not valid.
#' @export
#' @examples
#' astro_body_name(astro_body["SUN"])
#' astro_body_name(9L)
astro_body_name <- function(body) {
  astro_body_name_(as.integer(body))
}

#' Get the integer code for a celestial body by name
#'
#' Returns the integer code corresponding to the given English name.
#'
#' @param name One of the following strings: Sun, Moon, Mercury, Venus, Earth, Mars, Jupiter, Saturn, Uranus, Neptune, Pluto, EMB, SSB.
#' @return If `name` is one of the listed strings (case-sensitive), the returned value is the corresponding integer code (see [astro_body]), otherwise it is `-1`.
#' @export
#' @examples
#' astro_body_code("Sun")
#' astro_body_code("Neptune")
astro_body_code <- function(name) {
  astro_body_code_(as.character(name))
}
