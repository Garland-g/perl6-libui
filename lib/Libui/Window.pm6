use Libui::Raw;
#use Libui::Control;
use Libui::Container;

unit class Libui::Window 
#	does Libui::Control
	does Libui::Container;

has uiWindow $!window;
has $!size-changed-supply;
has $!closing-supply;

submethod BUILD(Str :$title, int32 :$width, int32 :$height, int32 :$has-menubar) {
	$!window = uiNewWindow($title, $width, $height, $has-menubar);
}

multi method new(Str $title, int32 $width = 640, int32 $height = 480, int32 $has-menubar = 0) { 
	self.bless(:$title, :$width, :$height, :$has-menubar);
}

method !set-content( Libui::Control $control) {
	uiWindowSetChild($!window, $control.Control);
}

#method append(Libui::Control $control) {
#	uiWindowSetChild($!window, $control.Control);
#}

method title() returns Str {
	return uiWindowTitle($!window);
}

method set-title(Str $title) {
	uiWindowSetTitle($!window, $title);
}

#| Fails until $window.show() has been run
method content-size(int32 $width is rw, int32 $height is rw) {
	uiWindowContentSize($!window, $width, $height);
}

method width() {
	my int32 $height;
	my int32 $width;
	self.content-size($width, $height);
	return $width;
}

method height() {
	my int32 $height;
	my int32 $width;
	self.content-size($width, $height);
	return $height;
}
#| Currently fails unless uiMain() has been run
method set-content-size(int32 $width, int32 $height) {
	uiWindowSetContentSize($!window, $width, $height);
}

method fullscreen() {
	return uiWindowFullscreen($!window);
}

method set-fullscreen(int32 $fullscreen) {
	uiWindowSetFullscreen($!window, $fullscreen);
}

method borderless() returns int32 {
	return uiWindowBorderless($!window);
}

method set-borderless(int32 $borderless) {
	uiWindowSetBorderless($!window, $borderless);
}

method margined() returns int32 {
	return uiWindowMargined($!window);
}

method set-margined(int32 $margined) {
	uiWindowSetMargined($!window, $margined);
}

method closing() returns Supply {
	$!closing-supply //= do {
		my $s = Supplier.new;
		uiWindowOnClosing($!window, -> $, $ {
			$s.emit(self);
			CATCH { default { note $_; } }
			0; #uiWindowOnClosing expects an int32
		},
		Str);
		return $s.Supply;
	}
}

method size-changed() returns Supply {
	$!size-changed-supply //= do {
		my $s = Supplier.new;
		uiWindowOnContentSizeChanged($!window, -> $, $ {
			$s.emit(self);
			CATCH { default { note $_; } }
			},
			Str);
		return $s.Supply;
	}
}

method !WIDGET() {
	return $!window;
}

## Utility methods that need a uiWindow

method open() returns Str {
	return uiOpenFile($!window);
}

method save() returns Str {
	return uiSaveFile($!window);
}

method msg-box(Str $title, Str $description) {
	uiMsgBox($!window, $title, $description);
}

method msg-box-err(Str $title, Str $description) {
	uiMsgBoxError($!window, $title, $description);
}
