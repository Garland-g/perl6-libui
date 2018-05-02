use v6;
use Test;
use Libui;

Libui-Init();

plan *;

my Libui::Tab $tab .= new;

my Libui::Button $button .= new('button');

my Libui::Entry $entry .= new;

is $tab.pages, 0, <Get number of tabs>;

subtest <Append new tab>, {
	plan 1;
	$tab.append('Button', $button);
	is $tab.pages, 1;
};

subtest <Insert new tab>, {
	plan 1;
	$tab.insert('Entry', 0, $entry);
	is $tab.pages, 2;
};

is $tab.margined(1), 0, <Get margin of tab>;

subtest <Set margin of tab>, {
	plan 1;
	$tab.set-margined(1, 1);
	is $tab.margined(1), 1;
};

subtest <Delete tab>, {
	plan 1;
	$tab.delete-item(1);
	is $tab.pages, 1;
};

done-testing;
# vi:syntax=perl6
