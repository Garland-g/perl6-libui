use v6;
use Test;
use Libui;

Libui::Init();

plan *;

my Libui::DateTimePicker $dtpicker .= new();

isa-ok $dtpicker, Libui::DateTimePicker, <Create a DateTimePicker>;

isa-ok $dtpicker.changed, Supply, <Get the supply>;

my Libui::Time $time = $dtpicker.time;

isa-ok $time.second(), Int, <Get the second>;
isa-ok $time.minute(), Int, <Get the minute>;
isa-ok $time.hour(), Int, <Get the hour>;
isa-ok $time.day-of-month(), Int, <Get the day-of-month>;
isa-ok $time.month(), Int, <Get the month>;
isa-ok $time.year(), Int, <Get the year>;
isa-ok $time.weekday(), Int, <Get the weekday>;
isa-ok $time.day-of-year(), Int, <Get the day of year>;
isa-ok $time.is-dst(), Int, <Get DST status>;

$time.second(0);
$time.minute(37);
$time.hour(2);
$time.day-of-month(10);
$time.month(3);
$time.year(115);
$time.weekday(3); #Tuesday
$time.day-of-year(62);
$time.set-dst(0);

is $time.second, 0, <Set second>;
is $time.minute, 37, <Set minute>;
is $time.hour, 2, <Set hour>;
is $time.day-of-month, 10, <Set day of month>;
is $time.month, 3, <Set month>;
is $time.year + 1900, 2015, <Set year>;
is $time.weekday, 3, <Set weekday>;
is $time.is-dst, 0, <Set DST flag>;

my Libui::TimePicker $tpicker .= new();

isa-ok $tpicker, Libui::TimePicker, <Create a TimePicker>;

$tpicker.time($time);

is $tpicker.time.minute, 37, <Set time of TimePicker>;

my Libui::DatePicker $dpicker .= new();

isa-ok $dpicker, Libui::DatePicker, <Create a DatePicker>;


done-testing;
# vi:syntax=perl6
