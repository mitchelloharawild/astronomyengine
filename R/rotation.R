#' Create an identity rotation matrix
#'
#' Returns a rotation matrix that has no effect on orientation.
#' This matrix can be the starting point for other operations,
#' such as using a series of calls to [astro_pivot()] to
#' create a custom rotation matrix.
#'
#' @return A list with components:
#'   \describe{
#'     \item{rot}{A 3x3 rotation matrix}
#'     \item{status}{Status code (0 = success)}
#'   }
#'
#' @export
#' @examples
#' # Create an identity matrix
#' id <- astro_identity_matrix()
#' id
astro_identity_matrix <- function() {
  astro_identity_matrix_()
}

#' Calculate the inverse of a rotation matrix
#'
#' Given a rotation matrix that performs some coordinate transform,
#' this function returns the matrix that reverses that transform.
#'
#' @param rotation A rotation matrix (list with `rot` component) as returned
#'   by [astro_identity_matrix()] or other rotation functions
#'
#' @return A rotation matrix that performs the opposite transformation
#'
#' @export
#' @examples
#' # Create a rotation and invert it
#' rot <- astro_identity_matrix()
#' inv <- astro_inverse_rotation(rot)
astro_inverse_rotation <- function(rotation) {
  astro_inverse_rotation_(rotation)
}

#' Combine two rotation matrices
#'
#' Given two rotation matrices, returns a combined rotation matrix that is
#' equivalent to rotating based on the first matrix, followed by the second.
#'
#' @param a The first rotation to apply
#' @param b The second rotation to apply
#'
#' @return The combined rotation matrix
#'
#' @export
#' @examples
#' # Combine two identity matrices (result is also identity)
#' rot_a <- astro_identity_matrix()
#' rot_b <- astro_identity_matrix()
#' combined <- astro_combine_rotation(rot_a, rot_b)
astro_combine_rotation <- function(a, b) {
  astro_combine_rotation_(a, b)
}

#' Re-orient a rotation matrix by pivoting around an axis
#'
#' Given a rotation matrix, a selected coordinate axis, and an angle in degrees,
#' this function pivots the rotation matrix by that angle around that coordinate
#' axis.
#'
#' For example, if you have rotation matrix that converts ecliptic coordinates (ECL)
#' to horizontal coordinates (HOR), but you really want to convert ECL to the orientation
#' of a telescope camera pointed at a given body, you can use `astro_pivot()` twice:
#' (1) pivot around the zenith axis by the body's azimuth, then (2) pivot around the
#' western axis by the body's altitude angle. The resulting rotation matrix will then
#' reorient ECL coordinates to the orientation of your telescope camera.
#'
#' @param rotation The input rotation matrix
#' @param axis An integer that selects which coordinate axis to rotate around:
#'   0 = x, 1 = y, 2 = z. Any other value will fail with an error.
#' @param angle An angle in degrees indicating the amount of rotation around the specified axis.
#'   Positive angles indicate rotation counterclockwise as seen from the positive
#'   direction along that axis, looking towards the origin point of the orientation system.
#'   Any finite number of degrees is allowed, but best precision will result from keeping
#'   `angle` in the range \[-360, +360\].
#'
#' @return A pivoted rotation matrix
#'
#' @export
#' @examples
#' # Create an identity matrix and pivot it
#' rot <- astro_identity_matrix()
#' pivoted <- astro_pivot(rot, axis = 2, angle = 45)  # Rotate 45° around z-axis
astro_pivot <- function(rotation, axis, angle) {
  astro_pivot_(rotation, axis, angle)
}

#' Apply a rotation to a vector
#'
#' This function transforms a vector in one orientation to a vector
#' in another orientation.
#'
#' @param rotation A rotation matrix that specifies how the orientation of the vector
#'   is to be changed
#' @param vector The vector whose orientation is to be changed. A list with components:
#'   \describe{
#'     \item{x}{The Cartesian x-coordinate in AU}
#'     \item{y}{The Cartesian y-coordinate in AU}
#'     \item{z}{The Cartesian z-coordinate in AU}
#'     \item{t}{The date and time (POSIXct) at which this vector is valid}
#'   }
#'
#' @return A vector in the orientation specified by `rotation`
#'
#' @export
#' @examples
#' # Create a vector and rotate it
#' vec <- list(x = 1, y = 0, z = 0, t = as.POSIXct("2024-01-01", tz = "UTC"))
#' rot <- astro_identity_matrix()
#' rotated <- astro_rotate_vector(rot, vec)
astro_rotate_vector <- function(rotation, vector) {
  astro_rotate_vector_(rotation, vector)
}

#' Convert spherical coordinates to Cartesian coordinates
#'
#' Given spherical coordinates and a time at which they are valid,
#' returns a vector of Cartesian coordinates. The returned value
#' includes the time, as required by the vector type.
#'
#' @param sphere A list with components:
#'   \describe{
#'     \item{lat}{Latitude angle: -90..+90 degrees}
#'     \item{lon}{Longitude angle: 0..360 degrees}
#'     \item{dist}{Distance in AU}
#'   }
#' @param time POSIXct time at which the coordinates are valid
#'
#' @return A list representing a vector with components:
#'   \describe{
#'     \item{x}{The Cartesian x-coordinate in AU}
#'     \item{y}{The Cartesian y-coordinate in AU}
#'     \item{z}{The Cartesian z-coordinate in AU}
#'     \item{t}{The date and time (POSIXct) at which this vector is valid}
#'     \item{status}{Status code (0 = success)}
#'   }
#'
#' @export
#' @examples
#' # Convert spherical to Cartesian
#' sphere <- list(lat = 0, lon = 0, dist = 1)
#' time <- as.POSIXct("2024-01-01", tz = "UTC")
#' vec <- astro_vector_from_sphere(sphere, time)
astro_vector_from_sphere <- function(sphere, time) {
  if (!inherits(time, "POSIXct")) {
    stop("time must be a POSIXct object")
  }
  time_posix <- as.numeric(time)
  astro_vector_from_sphere_(sphere, time_posix)
}

#' Convert Cartesian coordinates to spherical coordinates
#'
#' Given a Cartesian vector, returns latitude, longitude, and distance.
#'
#' @param vector A list with components:
#'   \describe{
#'     \item{x}{The Cartesian x-coordinate in AU}
#'     \item{y}{The Cartesian y-coordinate in AU}
#'     \item{z}{The Cartesian z-coordinate in AU}
#'     \item{t}{The date and time (POSIXct) at which this vector is valid}
#'   }
#'
#' @return A list with components:
#'   \describe{
#'     \item{lat}{Latitude angle: -90..+90 degrees}
#'     \item{lon}{Longitude angle: 0..360 degrees}
#'     \item{dist}{Distance in AU}
#'     \item{status}{Status code (0 = success)}
#'   }
#'
#' @export
#' @examples
#' # Convert Cartesian to spherical
#' vec <- list(x = 1, y = 0, z = 0, t = as.POSIXct("2024-01-01", tz = "UTC"))
#' sphere <- astro_sphere_from_vector(vec)
astro_sphere_from_vector <- function(vector) {
  astro_sphere_from_vector_(vector)
}

#' Calculate equatorial angular coordinates from an equatorial vector
#'
#' Given an equatorial vector, calculates equatorial angular coordinates
#' (right ascension and declination).
#'
#' @param vector A list with components:
#'   \describe{
#'     \item{x}{The Cartesian x-coordinate in AU}
#'     \item{y}{The Cartesian y-coordinate in AU}
#'     \item{z}{The Cartesian z-coordinate in AU}
#'     \item{t}{The date and time (POSIXct) at which this vector is valid}
#'   }
#'
#' @return A list with components:
#'   \describe{
#'     \item{ra}{Right ascension in sidereal hours}
#'     \item{dec}{Declination in degrees}
#'     \item{dist}{Distance to the celestial body in AU}
#'     \item{vec}{Equatorial coordinates in Cartesian vector form}
#'     \item{status}{Status code (0 = success)}
#'   }
#'
#' @export
#' @examples
#' # Convert vector to equatorial coordinates
#' vec <- list(x = 1, y = 0, z = 0, t = as.POSIXct("2024-01-01", tz = "UTC"))
#' equ <- astro_equator_from_vector(vec)
astro_equator_from_vector <- function(vector) {
  astro_equator_from_vector_(vector)
}

#' Calculate horizontal vector from apparent angular horizontal coordinates
#'
#' Given apparent angular horizontal coordinates, calculate horizontal vector.
#' The input azimuth is measured in degrees clockwise from north (east = +90).
#' The returned vector is in the horizontal system: x = north, y = west, z = zenith (up).
#'
#' @param sphere A list with components:
#'   \describe{
#'     \item{lat}{Refracted altitude angle in degrees}
#'     \item{lon}{Azimuth in degrees clockwise from north}
#'     \item{dist}{Distance from the observer to the object in AU}
#'   }
#' @param time POSIXct time of the observation
#' @param refraction Refraction option (0 = REFRACTION_NONE, 1 = REFRACTION_NORMAL, 2 = REFRACTION_JPLHOR).
#'   This specifies how refraction is to be removed from the altitude stored in `sphere$lat`.
#'
#' @return A list representing a vector in the horizontal system with components:
#'   \describe{
#'     \item{x}{North component in AU}
#'     \item{y}{West component in AU}
#'     \item{z}{Zenith (up) component in AU}
#'     \item{t}{The date and time (POSIXct)}
#'     \item{status}{Status code (0 = success)}
#'   }
#'
#' @export
#' @examples
#' # Convert horizontal coordinates to vector
#' sphere <- list(lat = 45, lon = 90, dist = 1)  # 45° altitude, 90° azimuth (east)
#' time <- as.POSIXct("2024-01-01 12:00:00", tz = "UTC")
#' vec <- astro_vector_from_horizon(sphere, time, refraction = 1)
astro_vector_from_horizon <- function(sphere, time, refraction = 1L) {
  if (!inherits(time, "POSIXct")) {
    stop("time must be a POSIXct object")
  }
  time_posix <- as.numeric(time)
  astro_vector_from_horizon_(sphere, time_posix, as.integer(refraction))
}

#' Convert horizontal vector to horizontal angular coordinates
#'
#' Given a horizontal Cartesian vector, returns horizontal azimuth and altitude.
#'
#' **IMPORTANT:** This function differs from [astro_sphere_from_vector()] in two ways:
#' - [astro_sphere_from_vector()] returns a `lon` value that represents azimuth defined
#'   counterclockwise from north (e.g., west = +90), but this function represents a
#'   clockwise rotation (e.g., east = +90). The difference is because
#'   [astro_sphere_from_vector()] is intended to preserve the vector "right-hand rule",
#'   while this function defines azimuth in a more traditional way as used in
#'   navigation and cartography.
#' - This function optionally corrects for atmospheric refraction, while
#'   [astro_sphere_from_vector()] does not.
#'
#' The returned structure contains the azimuth in `lon`.
#' It is measured in degrees clockwise from north: east = +90 degrees, west = +270 degrees.
#'
#' The altitude is stored in `lat`.
#'
#' The distance to the observed object is stored in `dist`, and is expressed in
#' astronomical units (AU).
#'
#' @param vector A list with components:
#'   \describe{
#'     \item{x}{North component in AU}
#'     \item{y}{West component in AU}
#'     \item{z}{Zenith (up) component in AU}
#'     \item{t}{The date and time (POSIXct)}
#'   }
#' @param refraction Refraction option (0 = REFRACTION_NONE, 1 = REFRACTION_NORMAL, 2 = REFRACTION_JPLHOR).
#'   REFRACTION_NORMAL: correct altitude for atmospheric refraction (recommended).
#'   REFRACTION_NONE: no atmospheric refraction correction is performed.
#'   REFRACTION_JPLHOR: for JPL Horizons compatibility testing only; not recommended for normal use.
#'
#' @return A list with components:
#'   \describe{
#'     \item{lat}{Altitude angle in degrees (corrected for refraction if requested)}
#'     \item{lon}{Azimuth in degrees clockwise from north}
#'     \item{dist}{Distance in AU}
#'     \item{status}{Status code (0 = success)}
#'   }
#'
#' @export
#' @examples
#' # Convert horizontal vector to angular coordinates
#' vec <- list(x = 0, y = -1, z = 0, t = as.POSIXct("2024-01-01", tz = "UTC"))
#' hor <- astro_horizon_from_vector(vec, refraction = 1)
astro_horizon_from_vector <- function(vector, refraction = 1L) {
  astro_horizon_from_vector_(vector, as.integer(refraction))
}


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
