use v6;
use Test;
use Libui;

Libui::Init();

plan *;

my Libui::Grid $grid .= new;

is $grid.padded, False, <Get state: padded>;

subtest <Set state: padded>, {
  plan 1;
  $grid.set-padded(1);
  is $grid.padded, True;
};

my Libui::VBox $vbox .= new;

$vbox.append($grid, 0);

my Libui::Button $button .= new('label');
my Libui::Entry $entry .= new;
my Libui::Button $button2 .= new('test');
my Libui::Entry $entry2 .= new;

lives-ok {
  $grid.append($button, 0, 0, 1, 1, 0, 0, 0, 0);
  $grid.append($entry, 1, 0, 1, 1, 1, 0, 0, 0);
}, <Append to grid>;

lives-ok {
  $grid.insert($entry2, $entry, 3, 1, 1, 1, 0, 0, 0);
  $grid.insert($button2, $entry2, 0, 1, 1, 0, 0, 0, 0);
}, <Insert in grid>;

dies-ok {
  $grid.append(Libui::Button, 2,2,1,1,False,0,False,0);
}, <Dies when appending type object of Libui::Control>;

done-testing;
# vi:syntax=perl6
