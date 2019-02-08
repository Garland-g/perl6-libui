use v6;
use NativeCall;
use Test;
use Libui;
use Color;

'if $*KERNEL ~~ "linux" {
        unless %*ENV<DISPLAY> || %*ENV<WAYLAND_DISPLAY> {
                exit 0;
        }
}'
plan *;

Libui::Init();

my $button = Libui::ColorButton.new;

isa-ok $button, Libui::ColorButton, <Create a colorbutton>;

isa-ok $button.changed, Supply, <Get colorbutton's supply>;

my num64 $nr;
my num64 $ng;
my num64 $nb;
my num64 $na;

subtest {
  $button.raw-set-color(255e0/255, 128e0/255, 64e0/255, 50e0/255);

  $button.raw-color($nr, $ng, $nb, $na);

  is-approx $nr, 255/255, <num64-r>;
  is-approx $ng, 128/255, <num64-g>;
  is-approx $nb, 64/255, <num64-b>;
  is-approx $na, 50/255, <num64-a>;
}, <Raw Set Color, Raw Get color>;

subtest {
  my Real ($r, $g, $b, $a);

  $button.raw-color($r, $g, $b, $a);
  is-approx $r, 255/255, <r>;
  is-approx $g, 128/255, <g>;
  is-approx $b,  64/255, <b>;
  is-approx $a,  50/255, <a>;
}, <Get Color with non-Num types>;

subtest {
  lives-ok {$button.set-color(Color.new(rgbad => [0.5, 0.25, 1, 1]))},
  <Set color from Color>;

  is $button.color.rgbad, [0.5, 0.25, 1, 1], <Get color from Color>;
}, <Set, Get color from Color>;

subtest {
  lives-ok {$button.set-color(rgbad => [1, 0.5, 0.25, 1])},
  <Set color from Color constructor>;

  is $button.color.rgbad, [1, 0.5, 0.25, 1], <Prove by retrieving color>;
}, <Set color from Color constructor>;

done-testing;
# vi:syntax=perl6
