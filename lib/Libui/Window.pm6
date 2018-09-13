use Libui::Raw :window;
use Libui::Container;

unit class Libui::Window
  does Libui::Container;

has uiWindow $!window;
has Supply $!size-changed-supply;
has Supply $!closing-supply;

submethod BUILD(Str :$title, int32 :$width = 640, int32 :$height = 480, int32 :$has-menubar = 1) {
  $!window = uiNewWindow($title, $width, $height, $has-menubar);
}

multi method new(Str $title, Int $width = 640, Int $height = 480, Int $has-menubar = 1) {
  self.bless(:$title, :$width, :$height, :$has-menubar);
}

method set-content( Libui::Control $control) {
  if $control.top-level {
    note "cannot place {$control.WHAT} into a Libui::Container";
  } else {
    uiWindowSetChild($!window, $control.Control);
  }
}

#method append(Libui::Control $control) {
#  uiWindowSetChild($!window, $control.Control);
#}

multi method title() returns Str {
  return uiWindowTitle($!window);
}

method set-title(Str $title) {
  uiWindowSetTitle($!window, $title);
}


multi method title(Str $title) {
  self.set-title($title);
}


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

method set-content-size(int32 $width, int32 $height) {
  uiWindowSetContentSize($!window, $width, $height);
}

multi method fullscreen() {
  return uiWindowFullscreen($!window);
}

method set-fullscreen(int32 $fullscreen) {
  uiWindowSetFullscreen($!window, $fullscreen);
}

multi method fullscreen(Int $fullscreen) {
  self.set-fullscreen($fullscreen);
}

multi method borderless() returns int32 {
  return uiWindowBorderless($!window);
}

method set-borderless(int32 $borderless) {
  uiWindowSetBorderless($!window, $borderless);
}

multi method borderless(Int $borderless) {
  self.set-borderless($borderless);
}

multi method margined() returns int32 {
  return uiWindowMargined($!window);
}

method set-margined(int32 $margined) {
  uiWindowSetMargined($!window, $margined);
}

multi method margined(Int $margined) {
  self.set-margined($margined);
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

=begin Window
=head2 Libui::Window

A window. One is created for you inside of each L<App|https://github.com/Garland-g/perl6-libui/wiki/App>.

Cannot be placed into other controls.

=head3 Methods

C<new(Str $title, Int $width = 640, Int $height = 480, Int $has-menubar = 1)>

Creates a window.

C<set-content(Libui::Control $control)>

Sets the child widget of the Window.

C<title() returns Str>

Returns the title of the Window.

C<set-title(Str $title)> or C<title(Str $title)>

Sets the title of the window.

C<width()>

Returns the width of the Window. Returns 1 until L<show()|https://github.com/Garland-g/perl6-libui/wiki/Control#safe-methods> has been run.

C<height()>

Returns the height of the Window. Returns 1 until L<show()|https://github.com/Garland-g/perl6-libui/wiki/Control#safe-methods> has been run.

C<set-content-size(int32 $width, int32 $height)>

Sets the width and height of the Window. Does nothing until the L<App|https://github.com/Garland-g/perl6-libui/wiki/App> is run

C<fullscreen() returns int32>

Returns the value of the fullscreen property.

C<set-fullscreen(int32 $fullscreen)> or C<fullscreen(Int $fullscreen)>

Sets the value of the fullscreen property.

C<borderless() returns int32>

Returns the value of the borderless property.

C<set-borderless(int32 $borderless)> or C<borderless(Int $borderless)>

Sets the value of the borderless property.

C<margined() returns int32>

Returns the value of the margined property.

C<set-margined(int32 $margined)> or C<margined(Int $margined)>

Sets the value of the margined property.

C<closing() returns Supply>

Returns a L<Supply|https://docs.perl6.org/Supply>. An event is emitted whenever the Window is signaled to close.

C<size-changed returns Supply>

Returns a L<Supply|https://docs.perl6.org/Supply>. An event is emitted whenever the Window's height or width changes.

C<open() returns Str>

Opens a native file chooser for opening files. Returns a Str that is the path to the chosen file.

C<save()>

Opens a native file chooser for saving files. Returns a Str that is the path to the chosen file.

C<msg-box(Str $title, Str $description)>

Opens a message box.

C<msg-box-err(Str $title, Str $description)>

Opens an error message box.
=end Window
