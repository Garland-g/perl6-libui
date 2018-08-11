use v6;
use Test;
use Libui;

Libui::Init();

plan *;

my $entry = Libui::Entry.new;

isa-ok $entry, Libui::Entry, <Create entry>;

isa-ok $entry.changed, Supply, <Get changed supply>;

subtest <Set and Get entry text>, {
	plan 1;
	$entry.set-text("text");
	is $entry.text(), "text",
};

is $entry.read-only, 0, <Get state: read-only>;

subtest <Set state: read-only>, {
	plan 1;
	$entry.set-read-only(1);
	is $entry.read-only, 1;
};

my $pwentry = Libui::PasswordEntry.new;
isa-ok $pwentry, Libui::PasswordEntry, <Create password entry>;

my $searchentry = Libui::SearchEntry.new;
isa-ok $searchentry, Libui::SearchEntry, <Create password entry>;

done-testing;
# vi:syntax=perl6
