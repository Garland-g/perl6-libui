use v6;
use Libui::Raw :time;

unit class Time is export;

has tm $!time;

submethod BUILD() {
	$!time .= new;
}

method tm() {
	return $!time;
}

method second() {
	return $!time.tm_sec;
}

method minute() {
	return $!time.tm_min;
}

method hour() {
	return $!time.tm_hour;
}

method day-of-month() {
	return $!time.tm_mday;
}

method month() {
	return $!time.tm_mon;
}

method year() {
	return $!time.tm_year;
}

#method weekday() {
#	return $!time.tm_wday;
#}

#method day-of-year() {
#	return $!time.tm_yday;
#}

#method isdst() {
#	return $!time.tm_isdst
#}
