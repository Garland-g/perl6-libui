use v6;
use Test;
use Libui;

plan 6;

if $*KERNEL ~~ "linux" {
  unless %*ENV<DISPLAY> || %*ENV<WAYLAND_DISPLAY> {
    skip-rest;
    exit 0;
  }
}

Libui::Init();

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

lives-ok {$button.set-selected(-1)}, <Set selected to -1>;
dies-ok {$button.set-selected(-300)}, <Block smaller values>;

dies-ok {$button.append(Str)}, <Append null Str button>;


done-testing;
# vi:syntax=perl6
