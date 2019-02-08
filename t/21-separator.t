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

lives-ok { Libui::VSeparator.new;}, <Create vertical separator>;

lives-ok { Libui::HSeparator.new;}, <Create horizontal separator>;

done-testing;
# vi:syntax=perl6
