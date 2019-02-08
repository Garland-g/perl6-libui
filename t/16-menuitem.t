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

my Libui::MenuItem $item = $menu.append-item('New');

isa-ok $item.clicked, Supply, <Get clicked supply>;

lives-ok {$item.disable();}, <Disable menu item>;

lives-ok {$item.enable();}, <Enable menu item>;

my Libui::MenuItem $check-item = $menu.append-check-item('Fullscreen');

is $check-item.checked, False, <Get state: checked>;

subtest <Set state: checked>, {
  plan 1;
  $check-item.set-checked(1);
  is $check-item.checked, True;
};

lives-ok {
  my Libui::MenuItem $pref-item = $menu.append-preferences-item;
}, <Create preferences item>;

lives-ok {
  my Libui::MenuItem $quit-item = $menu.append-quit-item;
}, <Create quit item>;

my Libui::Menu $menu2 .= new('Help');

lives-ok {
  my Libui::MenuItem $about-item = $menu2.append-about-item;
}, <Create about item>;

#Should this fail?
lives-ok {
  $item.checked;
}, <Non-check-item checked>;

done-testing;
# vi:syntax=perl6
