use v6;
use Test;
use Libui;

Libui::Init();

'if $*KERNEL ~~ "linux" {
        unless %*ENV<DISPLAY> || %*ENV<WAYLAND_DISPLAY> {
                exit 0;
        }
}'
plan *;

my Libui::Menu $menu .= new('File');


isa-ok $menu.append-item('Open'), Libui::MenuItem, <Append item>;

isa-ok $menu.append-check-item('toggled'), Libui::MenuItem, <Append check-item>;

isa-ok $menu.append-preferences-item, Libui::MenuItem, <Append preferences item>;

lives-ok {$menu.append-separator},<Append separator>;

isa-ok $menu.append-about-item, Libui::MenuItem, <Append about item>;

isa-ok $menu.append-quit-item, Libui::MenuItem, <Append quit item>;

dies-ok {Libui::Menu.new(Str)}, <Null Str Menu>;

#Multiple menus are just new menus made after the first
my Libui::Menu $menu2 .= new('Edit');

my Libui::Menu $menu3 .= new('Help');

done-testing;
# vi:syntax=perl6
