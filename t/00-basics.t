use v6;
use Test;
use Libui;

if $*KERNEL ~~ "linux" {
	unless %*ENV<DISPLAY> || %*ENV<WAYLAND_DISPLAY> {
		diag("Cannot continue without DISPLAY, skipping");
		exit 0;
	}
}

plan 1;

my $app;

lives-ok { Libui::Init(); }, 'Can access the libui library'
  or bail-out "Cannot proceed without the native libui library";

# vi:syntax=perl6
