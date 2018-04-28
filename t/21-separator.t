use v6;
use Test;
use Libui;

Init();

plan *;

lives-ok { Libui::VSeparator.new;}, <Create vertical separator>;

lives-ok { Libui::HSeparator.new;}, <Create horizontal separator>;

done-testing;
# vi:syntax=perl6
