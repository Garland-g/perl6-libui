use v6;
use Test;
use Libui;

if $*KERNEL ~~ "linux" {
	unless %*ENV<DISPLAY> || %*ENV<WAYLAND_DISPLAY> {
		exit 0;
	}
}

plan 5;
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
