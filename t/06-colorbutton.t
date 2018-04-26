use v6;
use NativeCall;
use Test;
use Libui;

plan *;

Init();

my $button = Libui::ColorButton.new;

isa-ok $button, Libui::ColorButton, <Create a colorbutton>;

isa-ok $button.changed, Supply, <Get colorbutton's supply>;

my num64 $r;
my num64 $g;
my num64 $b;
my num64 $a;

subtest {
$button.set-color(255e0, 128e0, 64e0, 50e0);

$button.color($r, $g, $b, $a);

is $r, 255, <r>;
is $g, 128, <g>;
is $b, 64, <b>;
is $a, 50, <a>;
}, <Set Color, Get color>;



done-testing;
# vi:syntax=perl6
