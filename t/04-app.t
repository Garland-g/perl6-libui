use v6;
use Test;
use Libui;

plan *;

my Libui::App $app;
Libui::Init();

lives-ok {$app .= new('test'); }, 'Create a Libui::App'
  or bail-out "Cannot proceed without an app";

isa-ok $app.root, Libui::Window, 'Get the root window';

my $box = Libui::VBox.new;
my $button = Libui::Button.new('test');
$box.append($button, 0);

lives-ok {$app.set-content($box); }, <Add a control to the window>;

my Libui::Window $window .= new("window");

my Libui::App $app2;
lives-ok {$app2 .= new($window)}, <Create application with existing window>;

dies-ok {Libui::App.new(Libui::Window)}, <App with Null window>;

done-testing;

# vi:syntax=perl6
