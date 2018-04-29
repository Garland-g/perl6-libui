use v6;
use Test;
use Libui;

Init();

plan *;

my Libui::Grid $grid .= new;

is $grid.padded, 0, <Get state: padded>;

subtest <Set state: padded>, {
	plan 1;
	$grid.set-padded(1);
	is $grid.padded, 1;
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
}

done-testing;
# vi:syntax=perl6
