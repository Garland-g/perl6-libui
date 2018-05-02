use v6;
use Test;
use Libui;

Libui-Init();

plan *;

my $vbox = Libui::VBox.new;

isa-ok $vbox, Libui::VBox, <Create VBox> or bail-out <Need VBox>;

my $hbox = Libui::HBox.new;

isa-ok $hbox, Libui::HBox, <Create HBox> or bail-out <Need HBox>;

my $button1 = Libui::Button.new("test");

my $button2 = Libui::Button.new("test");

my $button3 = Libui::Button.new("test");

lives-ok {$hbox.append($vbox, 0)}, <Single append>;

lives-ok {$vbox.append-list(($button1, $button2, $button3), (1, 0))}, 
 <Multiple append with mismatched elems>;

lives-ok {$vbox.delete-item(2);}, <Delete at $index>;

is $vbox.padded(), 0, <Get state: padded>;

subtest <Set state: padded>, {
	plan 1;
	$hbox.set-padded(1);
	is $hbox.padded, 1;
};

done-testing;
# vi:syntax=perl6
