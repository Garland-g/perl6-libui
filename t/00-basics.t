use v6;
use Test;
use Libui;

plan 1;

my $app;

lives-ok { Libui-Init(); }, 'Can access the libui library'
	or bail-out "Cannot proceed without the native libui library";

# vi:syntax=perl6
