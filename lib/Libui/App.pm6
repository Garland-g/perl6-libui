use v6;
use Libui::Raw;
use Libui::Window;
use Libui::Menu;
unit class Libui::App;

has Libui::Window $!window;

multi submethod BUILD(Str :$title!
							 ,Int :$width where { $width > 0 } = 640
							 ,Int  :$height where { $height > 0 } = 480
							 ,Int :$has-menubar = 1
							 ) {
	$!window = Libui::Window.new(title => $title, width => $width, height => $height, has-menubar => $has-menubar);
}

multi submethod BUILD(Libui::Window :$window) {
	$!window = $window;
}

multi method new( Str $title
								, Int $width  = 640
								, Int $height = 480
								, Int $has-menubar = 1
								) {
	self.bless(:$title, :$width, :$height, :$has-menubar);
}

multi method new(Libui::Window $window) {
	self.bless(:$window);
}

#| Get the Libui::Window
method root() returns Libui::Window {
	return $!window;
}

method window() returns Libui::Window {
	return $!window;
}

method show() {
	$!window.show();
}

method run() {
	self.show();
	uiMain();
}

method exit() {
	uiQuit();
}

method set-content(Libui::Control $control) {
	$!window.set-content($control);
}
