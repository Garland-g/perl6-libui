use v6;
use Test;
use Libui;

Init();

plan *;

my Libui::FontButton $button .= new;

isa-ok $button, Libui::FontButton, <Create fontbutton>;

isa-ok $button.changed, Supply, <Get changed supply>;

lives-ok {$button.font(); }, <Get font>;

#say $button.family;




done-testing;
# vi:syntax=perl6
