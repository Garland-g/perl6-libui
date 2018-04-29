use v6;
use Test;
use Libui;

plan *;

my $app;
Init(); 

lives-ok {$app = Libui::App.new('test'); }, 'Create a Libui::App'
	or bail-out "Cannot proceed without an app";

isa-ok $app.root, Libui::Window, 'Get the root window';

my $box = Libui::VBox.new;
my $button = Libui::Button.new('test');
$box.append($button, 0);

lives-ok {$app.set-content($box); }, <Add a control to the window>;


done-testing;

# vi:syntax=perl6
