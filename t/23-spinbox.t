use v6;
use Test;
use Libui;

Libui::Init();

plan *;

my Libui::Spinbox $spinbox .= new(100, 0);

isa-ok $spinbox.changed, Supply, <Get changed supply>;

is $spinbox.value, 0, <Get spinbox value>;

subtest <Set spinbox value>, {
	plan 1;
	$spinbox.set-value(40);
	is $spinbox.value, 40;
};



done-testing;
# vi:syntax=perl6
