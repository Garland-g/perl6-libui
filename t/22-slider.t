use v6;
use Test;
use Libui;

Libui::Init();

plan *;

my Libui::Slider $slider .= new(100, 0);

isa-ok $slider.changed, Supply, <Get changed supply>;

is $slider.value, 0, <Get slider value>;

subtest <Set slider value>, {
	plan 1;
	$slider.set-value(40);
	is $slider.value, 40;
};



done-testing;
# vi:syntax=perl6
