use v6;
use Test;
use Libui;

plan *;

Libui::Init();

my $combobox = Libui::Combobox.new;

isa-ok $combobox, Libui::Combobox, <Create a combobox> or bail-out;

isa-ok $combobox.changed, Supply, <Get changed supply>;

lives-ok { $combobox.append("test") }, <Append item to combobox>;

subtest 'selections', {
	plan 2;
	$combobox.append("2");
	lives-ok { $combobox.set-selected(1) }, <Select item in combobox>;
	is $combobox.selected, 1, <Get selected item in combobox>;
};


done-testing;
# vi:syntax=perl6
