use v6;
use Test;
use Libui;

plan 7;

if $*KERNEL ~~ "linux" {
  unless %*ENV<DISPLAY> || %*ENV<WAYLAND_DISPLAY> {
    skip-rest;
    exit 0;
  }
}

Libui::Init();

my Libui::DateTimePicker $dtpicker .= new();

isa-ok $dtpicker, Libui::DateTimePicker, <Create a DateTimePicker>;

isa-ok $dtpicker.changed, Supply, <Get the supply>;

my $time = $dtpicker.time;

isa-ok $time, DateTime, <Get the DateTime>;


my Libui::TimePicker $tpicker .= new();

isa-ok $tpicker, Libui::TimePicker, <Create a TimePicker>;

isa-ok $tpicker.time, DateTime, <Get the Time>;

#TODO: Re-enable next rakudo release
#$tpicker.time($time);
#is $tpicker.time.minute, 37, <Set time of TimePicker>;

my Libui::DatePicker $dpicker .= new();

isa-ok $dpicker, Libui::DatePicker, <Create a DatePicker>;

isa-ok $dpicker.time, Date, <Get the Date>;


done-testing;
# vi:syntax=perl6
