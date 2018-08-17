use v6;
use Test;
use Libui;

Libui::Init();

plan *;

my Libui::FontButton $button .= new;

isa-ok $button, Libui::FontButton, <Create fontbutton>;

isa-ok $button.changed, Supply, <Get changed supply>;

lives-ok {$button.font(); }, <Get font>;

is $button.family, 'Sans', <Get font family>;
is $button.size, 12, <Get font size>;
is $button.weight, 400, <Get font weight>;
is $button.italic, 0, <Get font italic>;
is $button.stretch, 4, <Get font stretch>;

done-testing;
# vi:syntax=perl6
