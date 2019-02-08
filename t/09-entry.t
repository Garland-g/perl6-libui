use v6;
use Test;
use Libui;

plan 8;

if $*KERNEL ~~ "linux" {
  unless %*ENV<DISPLAY> || %*ENV<WAYLAND_DISPLAY> {
    skip-rest;
    exit 0;
  }
}

Libui::Init();

my $entry = Libui::Entry.new;

isa-ok $entry, Libui::Entry, <Create entry>;

isa-ok $entry.changed, Supply, <Get changed supply>;

subtest <Set and Get entry text>, {
  plan 1;
  $entry.set-text("text");
  is $entry.text(), "text",
};

is $entry.read-only, False, <Get state: read-only>;

subtest <Set state: read-only>, {
  plan 1;
  $entry.set-read-only(True);
  is $entry.read-only, True;
};

my $pwentry = Libui::PasswordEntry.new;
isa-ok $pwentry, Libui::PasswordEntry, <Create password entry>;

my $searchentry = Libui::SearchEntry.new;
isa-ok $searchentry, Libui::SearchEntry, <Create password entry>;


dies-ok {Libui::Entry.new.set-text(Str)}, <Null Text>;

done-testing;
# vi:syntax=perl6
