use v6;
use Test;
use Libui;

Libui::Init();

plan *;

my Libui::RadioButton $button .= new;

isa-ok $button.changed, Supply, <Get changed supply>;

lives-ok {
$button.append('choice 1');
$button.append('choice 2');
}, <Append choice>;

subtest <Get and Set selected>, {
	plan 1;
	$button.set-selected(1);
	is $button.selected, 1;
};



done-testing;
# vi:syntax=perl6
