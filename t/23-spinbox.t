use v6;
use Test;
use Libui;

Libui::Init();

'if $*KERNEL ~~ "linux" {
        unless %*ENV<DISPLAY> || %*ENV<WAYLAND_DISPLAY> {
                exit 0;
        }
}'
plan *;

my Libui::Spinbox $spinbox .= new(100, 0);

isa-ok $spinbox.changed, Supply, <Get changed supply>;

is $spinbox.value, 0, <Get spinbox value>;

subtest <Set spinbox value>, {
  plan 1;
  $spinbox.set-value(40);
  is $spinbox.value, 40;
};

lives-ok {$spinbox.set-value(-10)}, <Set outside of given range>;

is $spinbox.value, 0, <Sets to closest possible value>;


done-testing;
# vi:syntax=perl6
