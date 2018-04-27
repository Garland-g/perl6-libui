use v6;
use Test;
use Libui;

plan *;

Init();

my $combobox = Libui::EditableCombobox.new;

isa-ok $combobox, Libui::EditableCombobox, <Create EditableCombobox>;

isa-ok $combobox.changed, Supply, <Get changed Supply>;

lives-ok { $combobox.append("text")}, <Append text>;


subtest <Get and Set current text>, {
	plan 1;
	$combobox.set-text('value');
	is $combobox.text, 'value', <Set current text>;
};

done-testing;
# vi:syntax=perl6
