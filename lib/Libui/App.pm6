use v6;
use Libui::Raw;
use Libui::Window;
unit class Libui::App;

has Libui::Window $!window;

submethod BUILD(
	Str :$title!,
	int32 :$width where { $width > 0 } = 640,
	int32 :$height where { $height > 0 } = 480,
	int32 :$has-menubar = 1,
) {
	$!window = Libui::Window.new(title => $title, width => $width, height => $height, has-menubar => $has-menubar);
}

multi method new( Str $title
								, int32 $width  = 640
								, int32 $height = 480
								, int32 $has-menubar = 1) {
	self.bless(:$title, :$width, :$height, :$has-menubar);
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
	$!window.set-content($control);
}
