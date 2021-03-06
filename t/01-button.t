use v6;
use Test;
use Libui;

plan 5;

if $*KERNEL ~~ "linux" {
  unless %*ENV<DISPLAY> || %*ENV<WAYLAND_DISPLAY> {
    skip-rest;
    exit;
  }
}

Libui::Init();
my $button = Libui::Button.new('test');

isa-ok $button, Libui::Button, <Create a Button> or bail-out "Cannot continue without a button";

isa-ok $button.clicked, Supply, <Get the supply>;

is $button.text, 'test', <Get the label>;

my Str $text = 'Ok';

$button.set-text($text);

is $button.text, $text, <Set the label>;

#null tests

dies-ok { $button = Libui::Button.new(Str)}, <Null String button>;



# vi:syntax=perl6
