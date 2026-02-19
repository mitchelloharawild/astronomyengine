#include <cpp11.hpp>
#include "astronomy/astronomy.h"

using namespace cpp11;

// ---------------------------------------------------------------------------
// Internal helpers
// ---------------------------------------------------------------------------

// Convert a POSIXct (seconds since 1970-01-01 UTC) to astro_time_t.
// Astronomy Engine epoch is J2000.0 = 2000-01-01 12:00:00 UTC
// = 946728000 seconds since Unix epoch.
static astro_time_t posix_to_astro(double posix_sec) {
  // Days since J2000.0
  double ut = (posix_sec - 946728000.0) / 86400.0;
  return Astronomy_TimeFromDays(ut);
}

// Convert astro_time_t back to POSIXct (seconds since Unix epoch).
static double astro_to_posix(astro_time_t t) {
  return t.ut * 86400.0 + 946728000.0;
}

// Map an integer body code to astro_body_t.
static astro_body_t int_to_body(int body_int) {
  return static_cast<astro_body_t>(body_int);
}

// ---------------------------------------------------------------------------
// [[cpp11::register]]
// Time utilities
// ---------------------------------------------------------------------------

[[cpp11::register]]
double astro_make_time_(int year, int month, int day,
                        int hour, int minute, double second) {
  astro_time_t t = Astronomy_MakeTime(year, month, day, hour, minute, second);
  return astro_to_posix(t);
}

[[cpp11::register]]
double astro_current_time_() {
  astro_time_t t = Astronomy_CurrentTime();
  return astro_to_posix(t);
}

// ---------------------------------------------------------------------------
// Body utilities
// ---------------------------------------------------------------------------

[[cpp11::register]]
std::string astro_body_name_(int body) {
  return std::string(Astronomy_BodyName(int_to_body(body)));
}

[[cpp11::register]]
int astro_body_code_(std::string name) {
  return static_cast<int>(Astronomy_BodyCode(name.c_str()));
}

// ---------------------------------------------------------------------------
// Position of Sun, Moon, and planets
// ---------------------------------------------------------------------------

[[cpp11::register]]
list astro_helio_vector_(int body, double time_posix) {
  astro_time_t t = posix_to_astro(time_posix);
  astro_vector_t vec = Astronomy_HelioVector(int_to_body(body), t);
  if (vec.status != ASTRO_SUCCESS)
    stop("Astronomy_HelioVector failed with status %d", vec.status);

  return writable::list({
    "x"_nm = vec.x,
    "y"_nm = vec.y,
    "z"_nm = vec.z,
    "time"_nm = astro_to_posix(vec.t)
  });
}

[[cpp11::register]]
list astro_equator_(int body, double time_posix, double latitude,
                    double longitude, double height,
                    bool of_date, bool aberration) {
  astro_time_t t = posix_to_astro(time_posix);
  astro_observer_t obs = Astronomy_MakeObserver(latitude, longitude, height);
  astro_equator_date_t equdate = of_date ? EQUATOR_OF_DATE : EQUATOR_J2000;
  astro_aberration_t aber = aberration ? ABERRATION : NO_ABERRATION;

  astro_equatorial_t eq = Astronomy_Equator(int_to_body(body), &t, obs, equdate, aber);
  if (eq.status != ASTRO_SUCCESS)
    stop("Astronomy_Equator failed with status %d", eq.status);

  return writable::list({
    "ra"_nm = eq.ra,
    "dec"_nm = eq.dec,
    "dist"_nm = eq.dist
  });
}

[[cpp11::register]]
list astro_sun_position_(double time_posix) {
  astro_time_t time = posix_to_astro(time_posix);
  astro_ecliptic_t ecl = Astronomy_SunPosition(time);
  
  if (ecl.status != ASTRO_SUCCESS)
    stop("Astronomy_SunPosition failed with status %d", ecl.status);
  
  return writable::list({
    "elon"_nm = ecl.elon,
    "elat"_nm = ecl.elat,
    "vec"_nm = writable::list({
      "x"_nm = ecl.vec.x,
      "y"_nm = ecl.vec.y,
      "z"_nm = ecl.vec.z,
      "t"_nm = astro_to_posix(ecl.vec.t)
    })
  });
}

[[cpp11::register]]
list astro_ecliptic_(double x, double y, double z, double time_posix) {
  astro_vector_t eqj;
  eqj.x = x;
  eqj.y = y;
  eqj.z = z;
  eqj.t = posix_to_astro(time_posix);
  eqj.status = ASTRO_SUCCESS;

  astro_ecliptic_t eclip = Astronomy_Ecliptic(eqj);
  if (eclip.status != ASTRO_SUCCESS)
    stop("Astronomy_Ecliptic failed with status %d", eclip.status);

  return writable::list({
    "x"_nm = eclip.vec.x,
    "y"_nm = eclip.vec.y,
    "z"_nm = eclip.vec.z,
    "lon"_nm = eclip.elon,
    "lat"_nm = eclip.elat,
    "time"_nm = astro_to_posix(eclip.vec.t)
  });
}

[[cpp11::register]]
double astro_ecliptic_longitude_(int body, double time_posix) {
  astro_time_t t = posix_to_astro(time_posix);
  astro_angle_result_t result = Astronomy_EclipticLongitude(int_to_body(body), t);
  if (result.status != ASTRO_SUCCESS)
    stop("Astronomy_EclipticLongitude failed with status %d", result.status);
  return result.angle;
}

[[cpp11::register]]
list astro_horizon_(double time_posix, double lat, double lon, double ra, double dec, int refraction) {
  astro_time_t time = posix_to_astro(time_posix);
  astro_observer_t observer;
  observer.latitude = lat;
  observer.longitude = lon;
  
  astro_horizon_t hor = Astronomy_Horizon(&time, observer, ra, dec, (astro_refraction_t)refraction);
  
  if (std::isnan(hor.altitude) || std::isnan(hor.azimuth)) {
    stop("Astronomy_Horizon returned invalid coordinates");
  }
  
  return writable::list({
    "azimuth"_nm = hor.azimuth,
    "altitude"_nm = hor.altitude,
    "ra"_nm = hor.ra,
    "dec"_nm = hor.dec
  });
}

[[cpp11::register]]
list astro_pair_longitude_(int body1, int body2, double time_posix) {
  astro_time_t time = posix_to_astro(time_posix);
  
  astro_angle_result_t result = Astronomy_PairLongitude((astro_body_t)body1, (astro_body_t)body2, time);
  
  if (result.status != ASTRO_SUCCESS) {
    stop("Astronomy_PairLongitude failed with status %d", result.status);
  }
  
  return writable::list({
    "angle"_nm = result.angle
  });
}

[[cpp11::register]]
list astro_geo_vector_(int body, double time_posix, int aberration) {
  astro_time_t time = posix_to_astro(time_posix);
  
  astro_vector_t vector = Astronomy_GeoVector((astro_body_t)body, time, (astro_aberration_t)aberration);
  
  if (vector.status != ASTRO_SUCCESS) {
    stop("Astronomy_GeoVector failed with status %d", vector.status);
  }
  
  return writable::list({
    "x"_nm = vector.x,
    "y"_nm = vector.y,
    "z"_nm = vector.z,
    "time"_nm = astro_to_posix(vector.t)
  });
}

[[cpp11::register]]
list astro_bary_state_(int body, double time_posix) {
  astro_time_t time = posix_to_astro(time_posix);
  
  astro_state_vector_t state = Astronomy_BaryState((astro_body_t)body, time);
  
  if (state.status != ASTRO_SUCCESS) {
    stop("Astronomy_BaryState failed with status %d", state.status);
  }
  
  return writable::list({
    "x"_nm = state.x,
    "y"_nm = state.y,
    "z"_nm = state.z,
    "vx"_nm = state.vx,
    "vy"_nm = state.vy,
    "vz"_nm = state.vz,
    "time"_nm = astro_to_posix(state.t)
  });
}

// ---------------------------------------------------------------------------
// Geographic helper functions
// ---------------------------------------------------------------------------

[[cpp11::register]]
list astro_observer_vector_(double time_posix, double latitude, 
                            double longitude, double height,
                            bool of_date) {
  astro_time_t t = posix_to_astro(time_posix);
  astro_observer_t observer = Astronomy_MakeObserver(latitude, longitude, height);
  astro_equator_date_t equdate = of_date ? EQUATOR_OF_DATE : EQUATOR_J2000;

  astro_vector_t vec = Astronomy_ObserverVector(&t, observer, equdate);
  if (vec.status != ASTRO_SUCCESS)
    stop("Astronomy_ObserverVector failed with status %d", vec.status);

  return writable::list({
    "x"_nm = vec.x,
    "y"_nm = vec.y,
    "z"_nm = vec.z,
    "t"_nm = astro_to_posix(vec.t),
    "status"_nm = static_cast<int>(vec.status)
  });
}

[[cpp11::register]]
list astro_observer_state_(double time_posix, double latitude,
                           double longitude, double height,
                           bool of_date) {
  astro_time_t t = posix_to_astro(time_posix);
  astro_observer_t observer = Astronomy_MakeObserver(latitude, longitude, height);
  astro_equator_date_t equdate = of_date ? EQUATOR_OF_DATE : EQUATOR_J2000;

  astro_state_vector_t state = Astronomy_ObserverState(&t, observer, equdate);
  if (state.status != ASTRO_SUCCESS)
    stop("Astronomy_ObserverState failed with status %d", state.status);

  return writable::list({
    "x"_nm = state.x,
    "y"_nm = state.y,
    "z"_nm = state.z,
    "vx"_nm = state.vx,
    "vy"_nm = state.vy,
    "vz"_nm = state.vz,
    "t"_nm = astro_to_posix(state.t),
    "status"_nm = static_cast<int>(state.status)
  });
}

[[cpp11::register]]
list astro_vector_observer_(list vector, bool of_date) {
  astro_vector_t vec;
  vec.x = cpp11::as_cpp<double>(vector["x"]);
  vec.y = cpp11::as_cpp<double>(vector["y"]);
  vec.z = cpp11::as_cpp<double>(vector["z"]);
  vec.t = posix_to_astro(cpp11::as_cpp<double>(vector["t"]));
  
  astro_equator_date_t equdate = of_date ? EQUATOR_OF_DATE : EQUATOR_J2000;
  astro_observer_t obs = Astronomy_VectorObserver(&vec, equdate);

  return writable::list({
    "latitude"_nm = obs.latitude,
    "longitude"_nm = obs.longitude,
    "height"_nm = obs.height
  });
}

[[cpp11::register]]
double astro_observer_gravity_(double latitude, double height) {
  return Astronomy_ObserverGravity(latitude, height);
}

// ---------------------------------------------------------------------------
// Rise, set, and culmination times
// ---------------------------------------------------------------------------

[[cpp11::register]]
SEXP astro_search_rise_set_ex_(int body, double latitude, double longitude,
                               double height, double time_posix, int direction,
                               double limit_days, double meters_above_ground) {
  astro_body_t c_body = static_cast<astro_body_t>(body);
  astro_observer_t observer = Astronomy_MakeObserver(latitude, longitude, height);
  astro_direction_t c_direction = static_cast<astro_direction_t>(direction);
  astro_time_t start_time = posix_to_astro(time_posix);

  astro_search_result_t result = Astronomy_SearchRiseSetEx(
    c_body, observer, c_direction, start_time, limit_days, meters_above_ground
  );

  if (result.status == ASTRO_SEARCH_FAILURE)
    return R_NilValue;

  if (result.status != ASTRO_SUCCESS)
    stop("Astronomy_SearchRiseSetEx failed with status %d", result.status);

  return cpp11::as_sexp(astro_to_posix(result.time));
}

[[cpp11::register]]
SEXP astro_search_altitude_(int body, double latitude, double longitude,
                            double height, double time_posix, int direction,
                            double limit_days, double altitude) {
  astro_body_t c_body = static_cast<astro_body_t>(body);
  astro_observer_t observer = Astronomy_MakeObserver(latitude, longitude, height);
  astro_direction_t c_direction = static_cast<astro_direction_t>(direction);
  astro_time_t start_time = posix_to_astro(time_posix);

  astro_search_result_t result = Astronomy_SearchAltitude(
    c_body, observer, c_direction, start_time, limit_days, altitude
  );

  if (result.status == ASTRO_SEARCH_FAILURE)
    return R_NilValue;

  if (result.status != ASTRO_SUCCESS)
    stop("Astronomy_SearchAltitude failed with status %d", result.status);

  return cpp11::as_sexp(astro_to_posix(result.time));
}

[[cpp11::register]]
list astro_search_hour_angle_ex_(int body, double latitude, double longitude,
                                 double height, double hour_angle,
                                 double time_posix, int direction) {
  astro_body_t c_body = static_cast<astro_body_t>(body);
  astro_observer_t observer = Astronomy_MakeObserver(latitude, longitude, height);
  astro_time_t start_time = posix_to_astro(time_posix);

  astro_hour_angle_t result = Astronomy_SearchHourAngleEx(
    c_body, observer, hour_angle, start_time, direction
  );

  if (result.status != ASTRO_SUCCESS)
    stop("Astronomy_SearchHourAngleEx failed with status %d", result.status);

  return writable::list({
    "time"_nm = astro_to_posix(result.time),
    "azimuth"_nm = result.hor.azimuth,
    "altitude"_nm = result.hor.altitude
  });
}

[[cpp11::register]]
double astro_hour_angle_(int body, double latitude, double longitude,
                         double height, double time_posix) {
  astro_body_t c_body = static_cast<astro_body_t>(body);
  astro_observer_t observer = Astronomy_MakeObserver(latitude, longitude, height);
  astro_time_t c_time = posix_to_astro(time_posix);

  astro_func_result_t result = Astronomy_HourAngle(c_body, &c_time, observer);

  if (result.status != ASTRO_SUCCESS)
    stop("Astronomy_HourAngle failed with status %d", result.status);

  return result.value;
}

// ---------------------------------------------------------------------------
// Moon phases
// ---------------------------------------------------------------------------

[[cpp11::register]]
double astro_moon_phase_(double time_posix) {
  astro_time_t t = posix_to_astro(time_posix);
  astro_angle_result_t result = Astronomy_MoonPhase(t);
  if (result.status != ASTRO_SUCCESS)
    stop("Astronomy_MoonPhase failed with status %d", result.status);

  return result.angle;
}

[[cpp11::register]]
double astro_search_moon_phase_(double target_lon, double start_time_posix, double limit_days) {
  astro_time_t start_t = posix_to_astro(start_time_posix);
  astro_search_result_t result = Astronomy_SearchMoonPhase(target_lon, start_t, limit_days);
  if (result.status != ASTRO_SUCCESS)
    stop("Astronomy_SearchMoonPhase failed with status %d", result.status);

  return astro_to_posix(result.time);
}

[[cpp11::register]]
cpp11::list astro_search_moon_quarter_(double start_time_posix) {
  astro_time_t start_t = posix_to_astro(start_time_posix);
  astro_moon_quarter_t result = Astronomy_SearchMoonQuarter(start_t);
  if (result.status != ASTRO_SUCCESS)
    stop("Astronomy_SearchMoonQuarter failed with status %d", result.status);

  return writable::list({
    "quarter"_nm = result.quarter,
    "time"_nm = astro_to_posix(result.time)
  });
}

[[cpp11::register]]
cpp11::list astro_next_moon_quarter_(int quarter, double time_posix) {
  astro_time_t t = posix_to_astro(time_posix);
  astro_moon_quarter_t mq;
  mq.quarter = quarter;
  mq.time = t;
  mq.status = ASTRO_SUCCESS;

  astro_moon_quarter_t result = Astronomy_NextMoonQuarter(mq);
  if (result.status != ASTRO_SUCCESS)
    stop("Astronomy_NextMoonQuarter failed with status %d", result.status);

  return writable::list({
    "quarter"_nm = result.quarter,
    "time"_nm = astro_to_posix(result.time)
  });
}

// ---------------------------------------------------------------------------
// Eclipses and Transits
// ---------------------------------------------------------------------------

[[cpp11::register]]
list astro_search_lunar_eclipse_(double start_time_posix) {
  astro_time_t start_time = posix_to_astro(start_time_posix);
  astro_lunar_eclipse_t eclipse = Astronomy_SearchLunarEclipse(start_time);
  
  if (eclipse.status != ASTRO_SUCCESS)
    stop("Astronomy_SearchLunarEclipse failed with status %d", eclipse.status);

  return writable::list({
    "kind"_nm = static_cast<int>(eclipse.kind),
    "obscuration"_nm = eclipse.obscuration,
    "peak"_nm = astro_to_posix(eclipse.peak),
    "sd_total"_nm = eclipse.sd_total,
    "sd_partial"_nm = eclipse.sd_partial,
    "sd_penum"_nm = eclipse.sd_penum
  });
}

[[cpp11::register]]
list astro_next_lunar_eclipse_(double prev_eclipse_time_posix) {
  astro_time_t prev_eclipse_time = posix_to_astro(prev_eclipse_time_posix);
  astro_lunar_eclipse_t eclipse = Astronomy_NextLunarEclipse(prev_eclipse_time);
  
  if (eclipse.status != ASTRO_SUCCESS)
    stop("Astronomy_NextLunarEclipse failed with status %d", eclipse.status);

  return writable::list({
    "kind"_nm = static_cast<int>(eclipse.kind),
    "obscuration"_nm = eclipse.obscuration,
    "peak"_nm = astro_to_posix(eclipse.peak),
    "sd_total"_nm = eclipse.sd_total,
    "sd_partial"_nm = eclipse.sd_partial,
    "sd_penum"_nm = eclipse.sd_penum
  });
}

// Helper to convert global solar eclipse struct to R list
static list global_eclipse_to_list(const astro_global_solar_eclipse_t& eclipse) {
  return writable::list({
    "status"_nm = static_cast<int>(eclipse.status),
    "kind"_nm = static_cast<int>(eclipse.kind),
    "peak"_nm = astro_to_posix(eclipse.peak),
    "distance"_nm = eclipse.distance,
    "latitude"_nm = eclipse.latitude,
    "longitude"_nm = eclipse.longitude
  });
}

// Helper to convert local solar eclipse struct to R list
static list local_eclipse_to_list(const astro_local_solar_eclipse_t& eclipse) {
  return writable::list({
    "status"_nm = static_cast<int>(eclipse.status),
    "kind"_nm = static_cast<int>(eclipse.kind),
    "partial_begin"_nm = writable::list({
      "time"_nm = astro_to_posix(eclipse.partial_begin.time),
      "altitude"_nm = eclipse.partial_begin.altitude
    }),
    "total_begin"_nm = writable::list({
      "time"_nm = astro_to_posix(eclipse.total_begin.time),
      "altitude"_nm = eclipse.total_begin.altitude
    }),
    "peak"_nm = writable::list({
      "time"_nm = astro_to_posix(eclipse.peak.time),
      "altitude"_nm = eclipse.peak.altitude
    }),
    "total_end"_nm = writable::list({
      "time"_nm = astro_to_posix(eclipse.total_end.time),
      "altitude"_nm = eclipse.total_end.altitude
    }),
    "partial_end"_nm = writable::list({
      "time"_nm = astro_to_posix(eclipse.partial_end.time),
      "altitude"_nm = eclipse.partial_end.altitude
    })
  });
}

[[cpp11::register]]
list search_global_solar_eclipse_(double start_time) {
  astro_time_t start = posix_to_astro(start_time);
  astro_global_solar_eclipse_t eclipse = Astronomy_SearchGlobalSolarEclipse(start);
  
  if (eclipse.status != ASTRO_SUCCESS)
    stop("Astronomy_SearchGlobalSolarEclipse failed with status %d", eclipse.status);
  
  return global_eclipse_to_list(eclipse);
}

[[cpp11::register]]
list next_global_solar_eclipse_(double prev_eclipse_time) {
  astro_time_t prev = posix_to_astro(prev_eclipse_time);
  astro_global_solar_eclipse_t eclipse = Astronomy_NextGlobalSolarEclipse(prev);
  
  if (eclipse.status != ASTRO_SUCCESS)
    stop("Astronomy_NextGlobalSolarEclipse failed with status %d", eclipse.status);
  
  return global_eclipse_to_list(eclipse);
}

[[cpp11::register]]
list search_local_solar_eclipse_(double start_time, double latitude, double longitude) {
  astro_time_t start = posix_to_astro(start_time);
  astro_observer_t observer = {latitude, longitude};
  astro_local_solar_eclipse_t eclipse = Astronomy_SearchLocalSolarEclipse(start, observer);
  
  if (eclipse.status != ASTRO_SUCCESS)
    stop("Astronomy_SearchLocalSolarEclipse failed with status %d", eclipse.status);
  
  return local_eclipse_to_list(eclipse);
}

[[cpp11::register]]
list next_local_solar_eclipse_(double prev_eclipse_time, double latitude, double longitude) {
  astro_time_t prev = posix_to_astro(prev_eclipse_time);
  astro_observer_t observer = {latitude, longitude};
  astro_local_solar_eclipse_t eclipse = Astronomy_NextLocalSolarEclipse(prev, observer);
  
  if (eclipse.status != ASTRO_SUCCESS)
    stop("Astronomy_NextLocalSolarEclipse failed with status %d", eclipse.status);
  
  return local_eclipse_to_list(eclipse);
}

[[cpp11::register]]
list astro_search_transit_(int body, double start_time_posix) {
  astro_time_t startTime = posix_to_astro(start_time_posix);
  
  astro_transit_t transit = Astronomy_SearchTransit((astro_body_t)body, startTime);
  if (transit.status != ASTRO_SUCCESS)
    stop("Astronomy_SearchTransit failed with status %d", transit.status);

  return writable::list({
    "start"_nm = astro_to_posix(transit.start),
    "peak"_nm = astro_to_posix(transit.peak),
    "finish"_nm = astro_to_posix(transit.finish),
    "separation"_nm = transit.separation
  });
}

[[cpp11::register]]
list astro_next_transit_(int body, double prev_transit_time_posix) {
  astro_time_t prevTransitTime = posix_to_astro(prev_transit_time_posix);
  
  astro_transit_t transit = Astronomy_NextTransit((astro_body_t)body, prevTransitTime);
  if (transit.status != ASTRO_SUCCESS)
    stop("Astronomy_NextTransit failed with status %d", transit.status);

  return writable::list({
    "start"_nm = astro_to_posix(transit.start),
    "peak"_nm = astro_to_posix(transit.peak),
    "finish"_nm = astro_to_posix(transit.finish),
    "separation"_nm = transit.separation
  });
}

// ---------------------------------------------------------------------------
// Lunar perigee and apogee
// ---------------------------------------------------------------------------

[[cpp11::register]]
list search_lunar_apsis_(double start_time) {
  astro_time_t start = posix_to_astro(start_time);
  astro_apsis_t apsis = Astronomy_SearchLunarApsis(start);
  
  if (apsis.status != ASTRO_SUCCESS)
    stop("Astronomy_SearchLunarApsis failed with status %d", apsis.status);
  
  return writable::list({
    "kind"_nm = (int)apsis.kind,
    "time"_nm = astro_to_posix(apsis.time),
    "dist_au"_nm = apsis.dist_au,
    "dist_km"_nm = apsis.dist_km
  });
}

[[cpp11::register]]
list next_lunar_apsis_(list apsis_list) {
  astro_apsis_t apsis;
  apsis.status = ASTRO_SUCCESS;
  apsis.kind = (astro_apsis_kind_t)cpp11::as_cpp<int>(apsis_list["kind"]);
  apsis.time = posix_to_astro(cpp11::as_cpp<double>(apsis_list["time"]));
  apsis.dist_au = cpp11::as_cpp<double>(apsis_list["dist_au"]);
  apsis.dist_km = cpp11::as_cpp<double>(apsis_list["dist_km"]);

  astro_apsis_t next = Astronomy_NextLunarApsis(apsis);
  
  if (next.status != ASTRO_SUCCESS)
    stop("Astronomy_NextLunarApsis failed with status %d", next.status);
  
  return writable::list({
    "kind"_nm = (int)next.kind,
    "time"_nm = astro_to_posix(next.time),
    "dist_au"_nm = next.dist_au,
    "dist_km"_nm = next.dist_km
  });
}

// ---------------------------------------------------------------------------
// Planet perihelion and aphelion
// ---------------------------------------------------------------------------

[[cpp11::register]]
list search_planet_apsis_(int body, doubles start_time) {
  astro_time_t start = posix_to_astro(start_time[0]);
  astro_apsis_t apsis = Astronomy_SearchPlanetApsis((astro_body_t)body, start);
  
  if (apsis.status != ASTRO_SUCCESS)
    stop("Astronomy_SearchPlanetApsis failed with status %d", apsis.status);
  
  return writable::list({
    "kind"_nm = (int)apsis.kind,
    "time"_nm = astro_to_posix(apsis.time),
    "dist_au"_nm = apsis.dist_au,
    "dist_km"_nm = apsis.dist_km
  });
}

[[cpp11::register]]
list next_planet_apsis_(int body, list apsis_list) {
  astro_apsis_t apsis;
  apsis.status = ASTRO_SUCCESS;
  apsis.kind = (astro_apsis_kind_t)cpp11::as_cpp<int>(apsis_list["kind"]);
  apsis.time = posix_to_astro(cpp11::as_cpp<double>(apsis_list["time"]));
  apsis.dist_au = cpp11::as_cpp<double>(apsis_list["dist_au"]);
  apsis.dist_km = cpp11::as_cpp<double>(apsis_list["dist_km"]);

  astro_apsis_t next = Astronomy_NextPlanetApsis((astro_body_t)body, apsis);
  
  if (next.status != ASTRO_SUCCESS)
    stop("Astronomy_NextPlanetApsis failed with status %d", next.status);
  
  return writable::list({
    "kind"_nm = (int)next.kind,
    "time"_nm = astro_to_posix(next.time),
    "dist_au"_nm = next.dist_au,
    "dist_km"_nm = next.dist_km
  });
}

// ---------------------------------------------------------------------------
// Visual magnitude and illumination
// ---------------------------------------------------------------------------

[[cpp11::register]]
list astro_illumination_(int body, double time_posix) {
  astro_body_t c_body = static_cast<astro_body_t>(body);
  astro_time_t c_time = posix_to_astro(time_posix);
  
  astro_illum_t illum = Astronomy_Illumination(c_body, c_time);
  if (illum.status != ASTRO_SUCCESS)
    stop("Astronomy_Illumination failed with status %d", illum.status);

  return writable::list({
    "time"_nm = astro_to_posix(illum.time),
    "mag"_nm = illum.mag,
    "phase_angle"_nm = illum.phase_angle,
    "phase_fraction"_nm = illum.phase_fraction,
    "helio_dist"_nm = illum.helio_dist,
    "ring_tilt"_nm = illum.ring_tilt
  });
}

[[cpp11::register]]
list astro_search_peak_magnitude_(int body, double start_time) {
  astro_body_t c_body = static_cast<astro_body_t>(body);
  astro_time_t c_start_time = posix_to_astro(start_time);
  
  astro_illum_t illum = Astronomy_SearchPeakMagnitude(c_body, c_start_time);
  if (illum.status != ASTRO_SUCCESS)
    stop("Astronomy_SearchPeakMagnitude failed with status %d", illum.status);

  return writable::list({
    "time"_nm = astro_to_posix(illum.time),
    "mag"_nm = illum.mag,
    "phase_angle"_nm = illum.phase_angle,
    "phase_fraction"_nm = illum.phase_fraction,
    "helio_dist"_nm = illum.helio_dist,
    "ring_tilt"_nm = illum.ring_tilt
  });
}

[[cpp11::register]]
double astro_angle_from_sun_(int body, double time) {
  astro_body_t c_body = static_cast<astro_body_t>(body);
  astro_time_t c_time = posix_to_astro(time);
  
  astro_angle_result_t result = Astronomy_AngleFromSun(c_body, c_time);
  if (result.status != ASTRO_SUCCESS)
    stop("Astronomy_AngleFromSun failed with status %d", result.status);
  
  return result.angle;
}

[[cpp11::register]]
list astro_elongation_(int body, double time) {
  astro_body_t c_body = static_cast<astro_body_t>(body);
  astro_time_t c_time = posix_to_astro(time);
  
  astro_elongation_t result = Astronomy_Elongation(c_body, c_time);
  if (result.status != ASTRO_SUCCESS)
    stop("Astronomy_Elongation failed with status %d", result.status);
  
  return writable::list({
    "visibility"_nm = static_cast<int>(result.visibility),
    "elongation"_nm = result.elongation,
    "ecliptic_separation"_nm = result.ecliptic_separation,
    "time"_nm = astro_to_posix(result.time),
    "status"_nm = static_cast<int>(result.status)
  });
}

[[cpp11::register]]
list astro_search_max_elongation_(int body, double start_time) {
  astro_body_t c_body = static_cast<astro_body_t>(body);
  astro_time_t c_start_time = posix_to_astro(start_time);
  
  astro_elongation_t result = Astronomy_SearchMaxElongation(c_body, c_start_time);
  if (result.status != ASTRO_SUCCESS)
    stop("Astronomy_SearchMaxElongation failed with status %d", result.status);
  
  return writable::list({
    "visibility"_nm = static_cast<int>(result.visibility),
    "elongation"_nm = result.elongation,
    "ecliptic_separation"_nm = result.ecliptic_separation,
    "time"_nm = astro_to_posix(result.time),
    "status"_nm = static_cast<int>(result.status)
  });
}

// ---------------------------------------------------------------------------
// Oppositions and conjunctions
// ---------------------------------------------------------------------------

[[cpp11::register]]
double astro_search_relative_longitude_(int body, double target_rel_lon, double start_time) {
  astro_body_t c_body = static_cast<astro_body_t>(body);
  astro_time_t c_start_time = posix_to_astro(start_time);
  
  astro_search_result_t result = Astronomy_SearchRelativeLongitude(
    c_body, 
    target_rel_lon, 
    c_start_time
  );
  
  if (result.status != ASTRO_SUCCESS)
    stop("Astronomy_SearchRelativeLongitude failed with status %d", result.status);

  return astro_to_posix(result.time);
}

// ---------------------------------------------------------------------------
// Equinoxes, solstices, and apparent solar motion
// ---------------------------------------------------------------------------

[[cpp11::register]]
double astro_search_sun_longitude_(double target_lon, double start_time, double limit_days) {
  astro_time_t start = posix_to_astro(start_time);
  astro_search_result_t result = Astronomy_SearchSunLongitude(target_lon, start, limit_days);
  
  if (result.status != ASTRO_SUCCESS)
    stop("Astronomy_SearchSunLongitude failed with status %d", result.status);
  
  return astro_to_posix(result.time);
}

[[cpp11::register]]
list astro_seasons_(int year) {
  astro_seasons_t s = Astronomy_Seasons(year);
  if (s.status != ASTRO_SUCCESS)
    stop("Astronomy_Seasons failed with status %d", s.status);

  return writable::list({
    "mar_equinox"_nm = astro_to_posix(s.mar_equinox),
    "jun_solstice"_nm = astro_to_posix(s.jun_solstice),
    "sep_equinox"_nm = astro_to_posix(s.sep_equinox),
    "dec_solstice"_nm = astro_to_posix(s.dec_solstice)
  });
}

// ---------------------------------------------------------------------------
// Lunar apsis (perigee / apogee)
// ---------------------------------------------------------------------------

[[cpp11::register]]
list astro_search_lunar_apsis_(double time_posix) {
  astro_time_t t = posix_to_astro(time_posix);
  astro_apsis_t apsis = Astronomy_SearchLunarApsis(t);
  if (apsis.status != ASTRO_SUCCESS)
    stop("Astronomy_SearchLunarApsis failed with status %d", apsis.status);

  return writable::list({
    "time"_nm = astro_to_posix(apsis.time),
    "kind"_nm = static_cast<int>(apsis.kind),
    "dist_au"_nm = apsis.dist_au,
    "dist_km"_nm = apsis.dist_km
  });
}

// ---------------------------------------------------------------------------
// Constellation
// ---------------------------------------------------------------------------

[[cpp11::register]]
list astro_constellation_(double ra, double dec) {
  astro_constellation_t con = Astronomy_Constellation(ra, dec);
  if (con.status != ASTRO_SUCCESS)
    stop("Astronomy_Constellation failed with status %d", con.status);

  return writable::list({
    "symbol"_nm = std::string(con.symbol),
    "name"_nm = std::string(con.name),
    "ra_1875"_nm = con.ra_1875,
    "dec_1875"_nm = con.dec_1875
  });
}

// ---------------------------------------------------------------------------
// Heliocentric distance
// ---------------------------------------------------------------------------

[[cpp11::register]]
double astro_helio_distance_(int body, double time_posix) {
  astro_time_t t = posix_to_astro(time_posix);
  astro_func_result_t result = Astronomy_HelioDistance(int_to_body(body), t);
  if (result.status != ASTRO_SUCCESS)
    stop("Astronomy_HelioDistance failed with status %d", result.status);
  return result.value;
}

// ---------------------------------------------------------------------------
// Global solar eclipse search
// ---------------------------------------------------------------------------

[[cpp11::register]]
list astro_search_global_solar_eclipse_(double time_posix) {
  astro_time_t t = posix_to_astro(time_posix);
  astro_global_solar_eclipse_t ec = Astronomy_SearchGlobalSolarEclipse(t);
  if (ec.status != ASTRO_SUCCESS)
    stop("Astronomy_SearchGlobalSolarEclipse failed with status %d", ec.status);

  return writable::list({
    "kind"_nm = static_cast<int>(ec.kind),
    "obscuration"_nm = ec.obscuration,
    "peak"_nm = astro_to_posix(ec.peak),
    "distance"_nm = ec.distance,
    "latitude"_nm = ec.latitude,
    "longitude"_nm = ec.longitude
  });
}

// ---------------------------------------------------------------------------
// Coordinate transformations: rotation matrices
// ---------------------------------------------------------------------------

// Helper to convert matrix to astro_rotation_t
static astro_rotation_t matrix_to_rotation(doubles mat) {
  astro_rotation_t rot;
  rot.status = ASTRO_SUCCESS;
  
  if (mat.size() != 9)
    stop("Rotation matrix must have exactly 9 elements");
  
  // R matrices are column-major, so we need to transpose
  rot.rot[0][0] = mat[0];  rot.rot[0][1] = mat[3];  rot.rot[0][2] = mat[6];
  rot.rot[1][0] = mat[1];  rot.rot[1][1] = mat[4];  rot.rot[1][2] = mat[7];
  rot.rot[2][0] = mat[2];  rot.rot[2][1] = mat[5];  rot.rot[2][2] = mat[8];
  
  return rot;
}

// Helper to convert astro_rotation_t to R matrix
static writable::doubles rotation_to_matrix(astro_rotation_t rot) {
  if (rot.status != ASTRO_SUCCESS)
    stop("Rotation matrix operation failed with status %d", rot.status);
  
  // Return as column-major for R
  writable::doubles mat(9);
  mat[0] = rot.rot[0][0];  mat[3] = rot.rot[0][1];  mat[6] = rot.rot[0][2];
  mat[1] = rot.rot[1][0];  mat[4] = rot.rot[1][1];  mat[7] = rot.rot[1][2];
  mat[2] = rot.rot[2][0];  mat[5] = rot.rot[2][1];  mat[8] = rot.rot[2][2];
  
  mat.attr("dim") = writable::integers({3, 3});
  
  return mat;
}

// Helper to convert list to astro_vector_t
static astro_vector_t list_to_vector(list vec_list) {
  astro_vector_t vec;
  vec.status = ASTRO_SUCCESS;
  vec.x = as_cpp<double>(vec_list["x"]);
  vec.y = as_cpp<double>(vec_list["y"]);
  vec.z = as_cpp<double>(vec_list["z"]);
  vec.t = posix_to_astro(as_cpp<double>(vec_list["t"]));
  return vec;
}

// Helper to convert astro_vector_t to R list
static list vector_to_list(astro_vector_t vec) {
  if (vec.status != ASTRO_SUCCESS)
    stop("Vector operation failed with status %d", vec.status);
  
  return writable::list({
    "x"_nm = vec.x,
    "y"_nm = vec.y,
    "z"_nm = vec.z,
    "t"_nm = astro_to_posix(vec.t),
    "status"_nm = static_cast<int>(vec.status)
  });
}

[[cpp11::register]]
doubles astro_identity_matrix_() {
  astro_rotation_t rot = Astronomy_IdentityMatrix();
  return rotation_to_matrix(rot);
}

[[cpp11::register]]
doubles astro_inverse_rotation_(doubles rotation) {
  astro_rotation_t rot = matrix_to_rotation(rotation);
  astro_rotation_t inv = Astronomy_InverseRotation(rot);
  return rotation_to_matrix(inv);
}

[[cpp11::register]]
doubles astro_combine_rotation_(doubles a, doubles b) {
  astro_rotation_t rot_a = matrix_to_rotation(a);
  astro_rotation_t rot_b = matrix_to_rotation(b);
  astro_rotation_t combined = Astronomy_CombineRotation(rot_a, rot_b);
  return rotation_to_matrix(combined);
}

[[cpp11::register]]
doubles astro_pivot_(doubles rotation, int axis, double angle) {
  astro_rotation_t rot = matrix_to_rotation(rotation);
  astro_rotation_t pivoted = Astronomy_Pivot(rot, axis, angle);
  return rotation_to_matrix(pivoted);
}

[[cpp11::register]]
list astro_rotate_vector_(doubles rotation, list vector) {
  astro_rotation_t rot = matrix_to_rotation(rotation);
  astro_vector_t vec = list_to_vector(vector);
  astro_vector_t rotated = Astronomy_RotateVector(rot, vec);
  return vector_to_list(rotated);
}

// ---------------------------------------------------------------------------
// Spherical / Cartesian coordinate conversions
// ---------------------------------------------------------------------------

// Helper to convert R list to astro_spherical_t
static astro_spherical_t list_to_spherical(list sphere_list) {
  astro_spherical_t sphere;
  sphere.status = ASTRO_SUCCESS;
  sphere.lat = as_cpp<double>(sphere_list["lat"]);
  sphere.lon = as_cpp<double>(sphere_list["lon"]);
  sphere.dist = as_cpp<double>(sphere_list["dist"]);
  return sphere;
}

// Helper to convert astro_spherical_t to R list
static list spherical_to_list(astro_spherical_t sphere) {
  if (sphere.status != ASTRO_SUCCESS)
    stop("Spherical coordinate operation failed with status %d", sphere.status);
  
  return writable::list({
    "lat"_nm = sphere.lat,
    "lon"_nm = sphere.lon,
    "dist"_nm = sphere.dist,
    "status"_nm = static_cast<int>(sphere.status)
  });
}

// Helper to convert astro_equatorial_t to R list
static list equatorial_to_list(astro_equatorial_t equ) {
  if (equ.status != ASTRO_SUCCESS)
    stop("Equatorial coordinate operation failed with status %d", equ.status);
  
  return writable::list({
    "ra"_nm = equ.ra,
    "dec"_nm = equ.dec,
    "dist"_nm = equ.dist,
    "vec"_nm = vector_to_list(equ.vec),
    "status"_nm = static_cast<int>(equ.status)
  });
}

[[cpp11::register]]
list astro_vector_from_sphere_(list sphere, double time_posix) {
  astro_spherical_t sph = list_to_spherical(sphere);
  astro_time_t t = posix_to_astro(time_posix);
  astro_vector_t vec = Astronomy_VectorFromSphere(sph, t);
  return vector_to_list(vec);
}

[[cpp11::register]]
list astro_sphere_from_vector_(list vector) {
  astro_vector_t vec = list_to_vector(vector);
  astro_spherical_t sphere = Astronomy_SphereFromVector(vec);
  return spherical_to_list(sphere);
}

[[cpp11::register]]
list astro_equator_from_vector_(list vector) {
  astro_vector_t vec = list_to_vector(vector);
  astro_equatorial_t equ = Astronomy_EquatorFromVector(vec);
  return equatorial_to_list(equ);
}

[[cpp11::register]]
list astro_vector_from_horizon_(list sphere, double time_posix, int refraction) {
  astro_spherical_t sph = list_to_spherical(sphere);
  astro_time_t t = posix_to_astro(time_posix);
  astro_refraction_t ref = static_cast<astro_refraction_t>(refraction);
  astro_vector_t vec = Astronomy_VectorFromHorizon(sph, t, ref);
  return vector_to_list(vec);
}

[[cpp11::register]]
list astro_horizon_from_vector_(list vector, int refraction) {
  astro_vector_t vec = list_to_vector(vector);
  astro_refraction_t ref = static_cast<astro_refraction_t>(refraction);
  astro_spherical_t sphere = Astronomy_HorizonFromVector(vec, ref);
  return spherical_to_list(sphere);
}

// ---------------------------------------------------------------------------
// Coordinate system rotation matrices
// ---------------------------------------------------------------------------

[[cpp11::register]]
doubles astro_rotation_eqd_eqj_(double time_posix) {
  astro_time_t t = posix_to_astro(time_posix);
  astro_rotation_t rot = Astronomy_Rotation_EQD_EQJ(&t);
  return rotation_to_matrix(rot);
}

[[cpp11::register]]
doubles astro_rotation_eqd_ect_(double time_posix) {
  astro_time_t t = posix_to_astro(time_posix);
  astro_rotation_t rot = Astronomy_Rotation_EQD_ECT(&t);
  return rotation_to_matrix(rot);
}

[[cpp11::register]]
doubles astro_rotation_eqd_ecl_(double time_posix) {
  astro_time_t t = posix_to_astro(time_posix);
  astro_rotation_t rot = Astronomy_Rotation_EQD_ECL(&t);
  return rotation_to_matrix(rot);
}

[[cpp11::register]]
doubles astro_rotation_eqd_hor_(double time_posix, double latitude,
                                double longitude, double height) {
  astro_time_t t = posix_to_astro(time_posix);
  astro_observer_t obs = Astronomy_MakeObserver(latitude, longitude, height);
  astro_rotation_t rot = Astronomy_Rotation_EQD_HOR(&t, obs);
  return rotation_to_matrix(rot);
}

[[cpp11::register]]
doubles astro_rotation_eqj_eqd_(double time_posix) {
  astro_time_t t = posix_to_astro(time_posix);
  astro_rotation_t rot = Astronomy_Rotation_EQJ_EQD(&t);
  return rotation_to_matrix(rot);
}

[[cpp11::register]]
doubles astro_rotation_eqj_ect_(double time_posix) {
  astro_time_t t = posix_to_astro(time_posix);
  astro_rotation_t rot = Astronomy_Rotation_EQJ_ECT(&t);
  return rotation_to_matrix(rot);
}

[[cpp11::register]]
doubles astro_rotation_eqj_ecl_() {
  astro_rotation_t rot = Astronomy_Rotation_EQJ_ECL();
  return rotation_to_matrix(rot);
}

[[cpp11::register]]
doubles astro_rotation_eqj_hor_(double time_posix, double latitude,
                                double longitude, double height) {
  astro_time_t t = posix_to_astro(time_posix);
  astro_observer_t obs = Astronomy_MakeObserver(latitude, longitude, height);
  astro_rotation_t rot = Astronomy_Rotation_EQJ_HOR(&t, obs);
  return rotation_to_matrix(rot);
}

[[cpp11::register]]
doubles astro_rotation_ect_eqd_(double time_posix) {
  astro_time_t t = posix_to_astro(time_posix);
  astro_rotation_t rot = Astronomy_Rotation_ECT_EQD(&t);
  return rotation_to_matrix(rot);
}

[[cpp11::register]]
doubles astro_rotation_ect_eqj_(double time_posix) {
  astro_time_t t = posix_to_astro(time_posix);
  astro_rotation_t rot = Astronomy_Rotation_ECT_EQJ(&t);
  return rotation_to_matrix(rot);
}

[[cpp11::register]]
doubles astro_rotation_ecl_eqd_(double time_posix) {
  astro_time_t t = posix_to_astro(time_posix);
  astro_rotation_t rot = Astronomy_Rotation_ECL_EQD(&t);
  return rotation_to_matrix(rot);
}

[[cpp11::register]]
doubles astro_rotation_ecl_eqj_() {
  astro_rotation_t rot = Astronomy_Rotation_ECL_EQJ();
  return rotation_to_matrix(rot);
}

[[cpp11::register]]
doubles astro_rotation_ecl_hor_(double time_posix, double latitude,
                                double longitude, double height) {
  astro_time_t t = posix_to_astro(time_posix);
  astro_observer_t obs = Astronomy_MakeObserver(latitude, longitude, height);
  astro_rotation_t rot = Astronomy_Rotation_ECL_HOR(&t, obs);
  return rotation_to_matrix(rot);
}

[[cpp11::register]]
doubles astro_rotation_hor_eqd_(double time_posix, double latitude,
                                double longitude, double height) {
  astro_time_t t = posix_to_astro(time_posix);
  astro_observer_t obs = Astronomy_MakeObserver(latitude, longitude, height);
  astro_rotation_t rot = Astronomy_Rotation_HOR_EQD(&t, obs);
  return rotation_to_matrix(rot);
}

[[cpp11::register]]
doubles astro_rotation_hor_eqj_(double time_posix, double latitude,
                                double longitude, double height) {
  astro_time_t t = posix_to_astro(time_posix);
  astro_observer_t obs = Astronomy_MakeObserver(latitude, longitude, height);
  astro_rotation_t rot = Astronomy_Rotation_HOR_EQJ(&t, obs);
  return rotation_to_matrix(rot);
}

[[cpp11::register]]
doubles astro_rotation_hor_ecl_(double time_posix, double latitude,
                                double longitude, double height) {
  astro_time_t t = posix_to_astro(time_posix);
  astro_observer_t obs = Astronomy_MakeObserver(latitude, longitude, height);
  astro_rotation_t rot = Astronomy_Rotation_HOR_ECL(&t, obs);
  return rotation_to_matrix(rot);
}

[[cpp11::register]]
doubles astro_rotation_eqj_gal_() {
  astro_rotation_t rot = Astronomy_Rotation_EQJ_GAL();
  return rotation_to_matrix(rot);
}

[[cpp11::register]]
doubles astro_rotation_gal_eqj_() {
  astro_rotation_t rot = Astronomy_Rotation_GAL_EQJ();
  return rotation_to_matrix(rot);
}
