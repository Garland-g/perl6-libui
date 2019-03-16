use v6;
use Test;
use Libui;

plan 1;

if $*KERNEL ~~ "linux" {
  unless %*ENV<DISPLAY> || %*ENV<WAYLAND_DISPLAY> {
    diag("Cannot test without DISPLAY, skipping");
    skip-rest;
    exit;
  }
}

my $app;

lives-ok { Libui::Init(); }, 'Can access the libui library'
  or bail-out "Cannot proceed without the native libui library";

# vi:syntax=perl6
