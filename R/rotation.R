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
#' @param time_posix
#'   A POSIXct object specifying the date and time at which the Earth's equator
#'   defines the target orientation.
#'
#' @return
#'   A rotation matrix that converts EQJ to ECL at the specified time.
#'
#' @examples
#' time <- as.POSIXct("2024-01-01", tz = "UTC")
#' astro_rotation_EQJ_ECL(time)
#'
#' @export
astro_rotation_EQJ_ECL <- function(time_posix) {
  astro_rotation_eqd_ecl_(time_posix)
}

#' Rotation Matrix from ECL to EQJ
#'
#' Calculates a rotation matrix from J2000 mean ecliptic (ECL) to J2000 mean
#' equator (EQJ).
#'
#' This is one of the family of functions that returns a rotation matrix
#' for converting from one orientation to another.
#'
#'   **Source**: ECL = ecliptic system, using equator at J2000 epoch.
#'
#'   **Target**: EQJ = equatorial system, using equator at J2000 epoch.
#'
#' @return
#'   A rotation matrix that converts ECL to EQJ.
#'
#' @examples
#' astro_rotation_ECL_EQJ()
#'
#' @export
astro_rotation_ECL_EQJ <- function() {
  astro_rotation_ecl_eqj_()
}

#' Rotation Matrix from EQJ to EQD
#'
#' Calculates a rotation matrix from J2000 mean equator (EQJ) to equatorial
#' of-date (EQD).
#'
#' This is one of the family of functions that returns a rotation matrix
#' for converting from one orientation to another.
#'
#'   **Source**: EQJ = equatorial system, using equator at J2000 epoch.
#'
#'   **Target**: EQD = equatorial system, using equator of the specified date/time.
#'
#' @param time_posix
#'   A POSIXct object specifying the date and time at which the Earth's equator
#'   defines the target orientation.
#'
#' @return
#'   A rotation matrix that converts EQJ to EQD at the specified time.
#'
#' @examples
#' time <- as.POSIXct("2024-01-01", tz = "UTC")
#' astro_rotation_EQJ_EQD(time)
#'
#' @export
astro_rotation_EQJ_EQD <- function(time_posix) {
  astro_rotation_eqj_eqd_(time_posix)
}

#' Rotation Matrix from EQJ to ECT
#'
#' Calculates a rotation matrix from J2000 mean equator (EQJ) to true ecliptic
#' of date (ECT).
#'
#' This is one of the family of functions that returns a rotation matrix
#' for converting from one orientation to another.
#'
#'   **Source**: EQJ = equatorial system, using mean equator at J2000 epoch.
#'
#'   **Target**: ECT = ecliptic system, using true equinox of the specified date/time.
#'
#' @param time_posix
#'   A POSIXct object specifying the date and time at which the Earth's equator
#'   defines the target orientation.
#'
#' @return
#'   A rotation matrix that converts EQJ to ECT at the specified time.
#'
#' @examples
#' time <- as.POSIXct("2024-01-01", tz = "UTC")
#' astro_rotation_EQJ_ECT(time)
#'
#' @export
astro_rotation_EQJ_ECT <- function(time_posix) {
  astro_rotation_eqj_ect_(time_posix)
}

#' Rotation Matrix from ECT to EQJ
#'
#' Calculates a rotation matrix from true ecliptic of date (ECT) to J2000 mean
#' equator (EQJ).
#'
#' This is one of the family of functions that returns a rotation matrix
#' for converting from one orientation to another.
#'
#'   **Source**: ECT = ecliptic system, using true equinox of the specified date/time.
#'
#'   **Target**: EQJ = equatorial system, using mean equator at J2000 epoch.
#'
#' @param time
#'   A POSIXct object representing the date and time at which the Earth's
#'   ecliptic defines the source orientation.
#'
#' @return
#'   A rotation matrix that converts ECT to EQJ.
#'
#' @examples
#' astro_rotation_ECT_EQJ(Sys.time())
#'
#' @export
astro_rotation_ECT_EQJ <- function(time) {
  astro_rotation_ect_eqj_(time)
}

#' Rotation Matrix from EQD to EQJ
#'
#' Calculates a rotation matrix from equatorial of-date (EQD) to J2000 mean
#' equator (EQJ).
#'
#' This is one of the family of functions that returns a rotation matrix
#' for converting from one orientation to another.
#'
#'   **Source**: EQD = equatorial system, using equator of the specified date/time.
#'
#'   **Target**: EQJ = equatorial system, using mean equator at J2000 epoch.
#'
#' @param time
#'   A POSIXct object representing the date and time at which the Earth's
#'   equator defines the source orientation.
#'
#' @return
#'   A rotation matrix that converts EQD to EQJ.
#'
#' @examples
#' astro_rotation_EQD_EQJ(Sys.time())
#'
#' @export
astro_rotation_EQD_EQJ <- function(time) {
  astro_rotation_eqd_eqj_(time)
}

#' Rotation Matrix from EQD to HOR
#'
#' Calculates a rotation matrix from equatorial of-date (EQD) to horizontal (HOR).
#'
#' This is one of the family of functions that returns a rotation matrix
#' for converting from one orientation to another.
#'
#'   **Source**: EQD = equatorial system, using equator of the specified date/time.
#'
#'   **Target**: HOR = horizontal system (x = north, y = west, z = zenith).
#'
#' @param time
#'   A POSIXct object representing the date and time at which the Earth's
#'   equator applies.
#'
#' @param latitude
#'   The observer's geographic latitude in degrees.
#'
#' @param longitude
#'   The observer's geographic longitude in degrees.
#'
#' @param height
#'   The observer's elevation above sea level in meters.
#'
#' @return
#'   A rotation matrix that converts EQD to HOR. The components of the horizontal
#'   vector are: x = north, y = west, z = zenith (straight up from the observer).
#'
#' @examples
#' astro_rotation_EQD_HOR(Sys.time(), latitude = -35.28, longitude = 149.12, height = 0)
#'
#' @export
astro_rotation_EQD_HOR <- function(time, latitude, longitude, height) {
  astro_rotation_eqd_hor_(time, latitude, longitude, height)
}

#' Rotation Matrix from HOR to EQD
#'
#' Calculates a rotation matrix from horizontal (HOR) to equatorial of-date (EQD).
#'
#' This is one of the family of functions that returns a rotation matrix
#' for converting from one orientation to another.
#'
#'   **Source**: HOR = horizontal system (x = north, y = west, z = zenith).
#'
#'   **Target**: EQD = equatorial system, using equator of the specified date/time.
#'
#' @param time
#'   A POSIXct object representing the date and time at which the Earth's
#'   equator applies.
#'
#' @param latitude
#'   The observer's geographic latitude in degrees.
#'
#' @param longitude
#'   The observer's geographic longitude in degrees.
#'
#' @param height
#'   The observer's elevation above sea level in meters.
#'
#' @return
#'   A rotation matrix that converts HOR to EQD.
#'
#' @examples
#' astro_rotation_HOR_EQD(Sys.time(), latitude = -35.28, longitude = 149.12, height = 0)
#'
#' @export
astro_rotation_HOR_EQD <- function(time, latitude, longitude, height) {
  astro_rotation_hor_eqd_(time, latitude, longitude, height)
}

#' Rotation Matrix from Horizontal to J2000 Equatorial
#'
#' Calculates a rotation matrix from horizontal (HOR) to J2000 mean equator (EQJ).
#'
#' This is one of the family of functions that returns a rotation matrix
#' for converting from one orientation to another.
#'
#'   **Source**: HOR = horizontal system (x=North, y=West, z=Zenith).
#'
#'   **Target**: EQJ = equatorial system, using equator at J2000 epoch.
#'
#' @param time
#'   A POSIXct object representing the date and time of observation.
#'
#' @param latitude
#'   The observer's geographic latitude in degrees.
#'
#' @param longitude
#'   The observer's geographic longitude in degrees.
#'
#' @param height
#'   The observer's elevation above sea level in meters.
#'
#' @return
#'   A rotation matrix that converts HOR to EQJ at `time` and for the observer.
#'
#' @examples
#' astro_rotation_HOR_EQJ(Sys.time(), latitude = -35.28, longitude = 149.12, height = 0)
#'
#' @export
astro_rotation_HOR_EQJ <- function(time, latitude, longitude, height) {
  astro_rotation_hor_eqj_(time, latitude, longitude, height)
}


#' Rotation Matrix from J2000 Equatorial to Horizontal
#'
#' Calculates a rotation matrix from J2000 mean equator (EQJ) to horizontal (HOR).
#'
#' This is one of the family of functions that returns a rotation matrix
#' for converting from one orientation to another.
#'
#'   **Source**: EQJ = equatorial system, using the equator at J2000 epoch.
#'
#'   **Target**: HOR = horizontal system (x=North, y=West, z=Zenith).
#'
#' @param time
#'   A POSIXct object representing the date and time of observation.
#'
#' @param latitude
#'   The observer's geographic latitude in degrees.
#'
#' @param longitude
#'   The observer's geographic longitude in degrees.
#'
#' @param height
#'   The observer's elevation above sea level in meters.
#'
#' @return
#'   A rotation matrix that converts EQJ to HOR. The components represent:
#'   x = north, y = west, z = zenith (straight up from observer).
#'
#' @examples
#' astro_rotation_EQJ_HOR(Sys.time(), latitude = -35.28, longitude = 149.12, height = 0)
#'
#' @export
astro_rotation_EQJ_HOR <- function(time, latitude, longitude, height) {
  astro_rotation_eqj_hor_(time, latitude, longitude, height)
}


#' Rotation Matrix from Equatorial of-Date to J2000 Ecliptic
#'
#' Calculates a rotation matrix from equatorial of-date (EQD) to J2000 mean
#' ecliptic (ECL).
#'
#' This is one of the family of functions that returns a rotation matrix
#' for converting from one orientation to another.
#'
#'   **Source**: EQD = equatorial system, using equator of date.
#'
#'   **Target**: ECL = ecliptic system, using equator at J2000 epoch.
#'
#' @param time
#'   A POSIXct object representing the date and time.
#'
#' @return
#'   A rotation matrix that converts EQD to ECL.
#'
#' @examples
#' astro_rotation_EQD_ECL(Sys.time())
#'
#' @export
astro_rotation_EQD_ECL <- function(time) {
  astro_rotation_eqd_ecl_(time)
}


#' Rotation Matrix from J2000 Ecliptic to Equatorial of-Date
#'
#' Calculates a rotation matrix from J2000 mean ecliptic (ECL) to equatorial
#' of-date (EQD).
#'
#' This is one of the family of functions that returns a rotation matrix
#' for converting from one orientation to another.
#'
#'   **Source**: ECL = ecliptic system, using equator at J2000 epoch.
#'
#'   **Target**: EQD = equatorial system, using equator of date.
#'
#' @param time
#'   A POSIXct object representing the date and time.
#'
#' @return
#'   A rotation matrix that converts ECL to EQD.
#'
#' @examples
#' astro_rotation_ECL_EQD(Sys.time())
#'
#' @export
astro_rotation_ECL_EQD <- function(time) {
  astro_rotation_ecl_eqd_(time)
}

#' Rotation Matrix from ECL to HOR
#'
#' Calculates a rotation matrix from J2000 mean ecliptic (ECL) to horizontal (HOR).
#'
#' This is one of the family of functions that returns a rotation matrix
#' for converting from one orientation to another.
#'
#'   **Source**: ECL = ecliptic system, using equator at J2000 epoch.
#'
#'   **Target**: HOR = horizontal system (x = north, y = west, z = zenith).
#'
#' @param time
#'   A POSIXct object representing the date and time of observation.
#'
#' @param latitude
#'   The observer's geographic latitude in degrees.
#'
#' @param longitude
#'   The observer's geographic longitude in degrees.
#'
#' @param height
#'   The observer's elevation above sea level in meters.
#'
#' @return
#'   A rotation matrix that converts ECL to HOR. The components of the
#'   horizontal vector are: x = north, y = west, z = zenith (straight up from
#'   the observer).
#'
#' @examples
#' astro_rotation_ECL_HOR(Sys.time(), latitude = -35.28, longitude = 149.12, height = 0)
#'
#' @export
astro_rotation_ECL_HOR <- function(time, latitude, longitude, height) {
  astro_rotation_ecl_hor_(time, latitude, longitude, height)
}

#' Rotation Matrix from HOR to ECL
#'
#' Calculates a rotation matrix from horizontal (HOR) to J2000 mean ecliptic (ECL).
#'
#' This is one of the family of functions that returns a rotation matrix
#' for converting from one orientation to another.
#'
#'   **Source**: HOR = horizontal system (x = north, y = west, z = zenith).
#'
#'   **Target**: ECL = ecliptic system, using equator at J2000 epoch.
#'
#' @param time
#'   A POSIXct object representing the date and time of observation.
#'
#' @param latitude
#'   The observer's geographic latitude in degrees.
#'
#' @param longitude
#'   The observer's geographic longitude in degrees.
#'
#' @param height
#'   The observer's elevation above sea level in meters.
#'
#' @return
#'   A rotation matrix that converts HOR to ECL.
#'
#' @examples
#' astro_rotation_HOR_ECL(Sys.time(), latitude = -35.28, longitude = 149.12, height = 0)
#'
#' @export
astro_rotation_HOR_ECL <- function(time, latitude, longitude, height) {
  astro_rotation_hor_ecl_(time, latitude, longitude, height)
}

#' Rotation Matrix from EQJ to GAL
#'
#' Calculates a rotation matrix from J2000 mean equator (EQJ) to galactic (GAL).
#'
#' This is one of the family of functions that returns a rotation matrix
#' for converting from one orientation to another.
#'
#'   **Source**: EQJ = equatorial system, using the equator at the J2000 epoch.
#'
#'   **Target**: GAL = galactic system (IAU 1958 definition).
#'
#' @return
#'   A rotation matrix that converts EQJ to GAL.
#'
#' @examples
#' astro_rotation_EQJ_GAL()
#'
#' @export
astro_rotation_EQJ_GAL <- function() {
  astro_rotation_eqj_gal_()
}

#' Rotation Matrix from GAL to EQJ
#'
#' Calculates a rotation matrix from galactic (GAL) to J2000 mean equator (EQJ).
#'
#' This is one of the family of functions that returns a rotation matrix
#' for converting from one orientation to another.
#'
#'   **Source**: GAL = galactic system (IAU 1958 definition).
#'
#'   **Target**: EQJ = equatorial system, using the equator at the J2000 epoch.
#'
#' @return
#'   A rotation matrix that converts GAL to EQJ.
#'
#' @examples
#' astro_rotation_GAL_EQJ()
#'
#' @export
astro_rotation_GAL_EQJ <- function() {
  astro_rotation_gal_eqj_()
}

#' Rotation Matrix from ECT to EQD
#'
#' Calculates a rotation matrix from true ecliptic of date (ECT) to equator of date (EQD).
#'
#' This is one of the family of functions that returns a rotation matrix
#' for converting from one orientation to another.
#'
#'   **Source**: ECT = true ecliptic of date.
#'
#'   **Target**: EQD = equator of date.
#'
#' @param time
#'   A POSIXct object representing the date and time of the ecliptic/equator conversion.
#'
#' @return
#'   A rotation matrix that converts ECT to EQD.
#'
#' @examples
#' astro_rotation_ECT_EQD(Sys.time())
#'
#' @export
astro_rotation_ECT_EQD <- function(time) {
  astro_rotation_ect_eqd_(time)
}

#' Rotation Matrix from EQD to ECT
#'
#' Calculates a rotation matrix from equator of date (EQD) to true ecliptic
#' of date (ECT).
#'
#' This is one of the family of functions that returns a rotation matrix
#' for converting from one orientation to another.
#'
#'   **Source**: EQD = equator of date.
#'
#'   **Target**: ECT = true ecliptic of date.
#'
#' @param time
#'   A POSIXct object representing the date and time of the equator/ecliptic
#'   conversion.
#'
#' @return
#'   A rotation matrix that converts EQD to ECT.
#'
#' @examples
#' astro_rotation_EQD_ECT(Sys.time())
#'
#' @export
astro_rotation_EQD_ECT <- function(time) {
  astro_rotation_eqd_ect_(time)
}
