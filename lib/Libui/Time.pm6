use NativeCall;

unit class Libui::Time is repr('CStruct') is export;
has int32 $!tm_sec;   # seconds [0,61]
has int32 $!tm_min;   # minutes [0,59]
has int32 $!tm_hour;  # hour [0,23]
has int32 $!tm_mday;  # day of month [1,31]
has int32 $!tm_mon;   # month of year [0,11]
has int32 $!tm_year;  # years since 1900
has int32 $!tm_wday;  # day of week [0-6], (Sunday = 0)
has int32 $!tm_yday;  # day of year [0,365]
has int32 $!tm_isdst; # daylight savings flag
has long  $!tm_gmtoff;
has Str   $!tm_zone;

multi method second() {
  return $!tm_sec;
}

multi method second(Int $sec) {
  $!tm_sec = $sec if 0 <= $sec <= 61;
}

multi method minute() {
  return $!tm_min;
}

multi method minute(Int $min) {
  $!tm_min = $min if 0 <= $min <= 59;
}

multi method hour() {
  return $!tm_hour;
}

multi method hour(Int $hour) {
  $!tm_hour = $hour if 0 <= $hour
}

multi method day-of-month() {
  return $!tm_mday;
}

multi method day-of-month(Int $mday) {
  $!tm_mday = $mday if 0 <= $mday <= 31;
}

multi method month() {
  return $!tm_mon;
}

multi method month(Int $month) {
  $!tm_mon = $month if 0 <= $month <= 11;
}

multi method year() {
  return $!tm_year;
}

multi method year(Int $year) {
  $!tm_year = $year;
}

multi method weekday() {
  return $!tm_wday;
}

multi method weekday(Int $wday) {
  $!tm_wday = $wday if 0 <= $wday <= 6;
}

multi method day-of-year() {
  return $!tm_yday;
}

multi method day-of-year(Int $yday) {
  $!tm_yday = $yday if 0 <= $yday <= 365;
}

multi method is-dst() {
  return $!tm_isdst;
}

multi method set-dst(Int $dst) {
  $!tm_isdst = $dst;
}

