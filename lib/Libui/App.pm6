use v6;
use Libui::Raw;
use Libui::Window;
unit class Libui::App;

has Libui::Window $!window;

submethod BUILD(
	Str :$title!,
	UInt :$width = 640,
	UInt :$height = 480,
	UInt :$has-menubar = 1,
) {
	$!window = Libui::Window.new(title => $title, width => $width, height => $height, has-menubar => $has-menubar);
}

method root() {
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
	uiWindowSetChild($!window.WIDGET, $control.Control);
}
