use v6;
use Test;
use Libui;

plan 2;

if $*KERNEL ~~ "linux" {
  unless %*ENV<DISPLAY> || %*ENV<WAYLAND_DISPLAY> {
    skip-rest;
    exit 0;
  }
}

Libui::Init();

lives-ok { Libui::VSeparator.new;}, <Create vertical separator>;

lives-ok { Libui::HSeparator.new;}, <Create horizontal separator>;

done-testing;
# vi:syntax=perl6
