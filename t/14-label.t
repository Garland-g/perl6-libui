use v6;
use Test;
use Libui;

plan 4;

if $*KERNEL ~~ "linux" {
  unless %*ENV<DISPLAY> || %*ENV<WAYLAND_DISPLAY> {
    skip-rest;
    exit 0;
  }
}

Libui::Init();

my Libui::Label $label .= new('text');

isa-ok $label, Libui::Label, <Create a label>;

is $label.text, 'text', <Get text>;

subtest <Set text>, {
  plan 1;
  $label.set-text('value');
  is $label.text, 'value';
};

dies-ok {Libui::Label.new(Str)}, <Null label>;

done-testing;
# vi:syntax=perl6
