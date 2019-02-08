use v6;
use Test;
use Libui;

plan 9;

if $*KERNEL ~~ "linux" {
  unless %*ENV<DISPLAY> || %*ENV<WAYLAND_DISPLAY> {
    skip-rest;
    exit;
  }
}

Libui::Init();

my $vbox = Libui::VBox.new;

isa-ok $vbox, Libui::VBox, <Create VBox> or bail-out <Need VBox>;

my $hbox = Libui::HBox.new;

isa-ok $hbox, Libui::HBox, <Create HBox> or bail-out <Need HBox>;

my $button1 = Libui::Button.new("test");

my $button2 = Libui::Button.new("test");

my $button3 = Libui::Button.new("test");

lives-ok {$hbox.append($vbox, 0)}, <Single append>;

$vbox.append($button1, 1);
$vbox.append($button2, 0);
$vbox.append($button3, 0);

#lives-ok {$vbox.append-list(($button1, $button2, $button3), (1, 0))},
# <Multiple append with mismatched elems>;

lives-ok {$vbox.delete-item(2)}, <Delete at $index>;

#If we get past this test, no segfault can happen with deleting an item
#This also checks the off-by-one error of item number vs array indexing
throws-like {$vbox.delete-item(2)}, Exception, <Delete out of range>;

is $vbox.padded(), False, <Get state: padded>;

subtest <Set state: padded>, {
  plan 1;
  $hbox.set-padded(1);
  is $hbox.padded, True;
};

dies-ok {$vbox.delete-item(-1)}, <Delete negative position>;

dies-ok {$vbox.append(Libui::Button)}, <Append type object>;

done-testing;
# vi:syntax=perl6
