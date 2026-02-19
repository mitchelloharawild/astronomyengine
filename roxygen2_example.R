#' Rotation Matrix from EQJ to ECL
#'
#' Calculates a rotation matrix from J2000 mean equator (EQJ) to J2000 mean
#' ecliptic (ECL).
#'
#' This is one of the family of functions that returns a rotation matrix
#' for converting from one orientation to another.
#'
#'   **Source**: EQJ = equatorial system, using equator at J2000 epoch.
#'
#'   **Target**: ECL = ecliptic system, using equator at J2000 epoch.
#'
#' @return
#'   A rotation matrix that converts EQJ to ECL.
#'
#' @examples
#' astro_rotation_EQJ_ECL()
#'
#' @export
astro_rotation_EQJ_ECL <- function() {
  .Call(`_astronomyengine_astro_rotation_eqj_ecl_`)
}
