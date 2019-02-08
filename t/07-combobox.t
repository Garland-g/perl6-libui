use v6;
use Test;
use Libui;

plan 7;

if $*KERNEL ~~ "linux" {
  unless %*ENV<DISPLAY> || %*ENV<WAYLAND_DISPLAY> {
    skip-rest;
    exit 0;
  }
}
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

lives-ok {$combobox.set-selected(-1)}, <Can select -1>;

dies-ok {$combobox.set-selected(-2)}, <Cannot select less than -1>;

dies-ok {$combobox.append(Str)}, <Append null text>;

done-testing;
# vi:syntax=perl6
