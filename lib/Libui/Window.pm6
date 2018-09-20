use Libui::Raw :window;
use Libui::Container;

unit class Libui::Window
  does Libui::Container;

has uiWindow $!window;
has Supply $!size-changed-supply;
has Supply $!closing-supply;

submethod BUILD(Str:D :$title, Int :$width = 640, Int :$height = 480, Bool(Int) :$has-menubar = 1) {
  $!window = uiNewWindow($title, $width, $height, $has-menubar);
}

multi method new(Str $title, Int $width = 640, Int $height = 480, Bool(Int) $has-menubar = 1) {
  self.bless(:$title, :$width, :$height, :$has-menubar);
}

method set-content( Libui::Control:D $control) {
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

method set-title(Str:D $title) {
  uiWindowSetTitle($!window, $title);
}


multi method title(Str:D $title) {
  self.set-title($title);
}


multi method content-size($width is rw where Int ~~ *, $height is rw where Int ~~ *) {
  my int32 ($h, $w);
  uiWindowContentSize($!window, $w, $h);
  ($height, $width) = ($h, $w);
}

multi method content-size(int32 $width is rw, int32 $height is rw) {
  uiWindowContentSize($!window, $width, $height);
}

method width() returns UInt {
  my int32 $height;
  my int32 $width;
  self.content-size($width, $height);
  return $width;
}

method height() returns UInt {
  my int32 $height;
  my int32 $width;
  self.content-size($width, $height);
  return $height;
}

method set-content-size(UInt:D $width, UInt:D $height) {
  uiWindowSetContentSize($!window, $width, $height);
}

multi method fullscreen() returns Bool {
  return uiWindowFullscreen($!window).Bool;
}

method set-fullscreen(Bool:D(Int) $fullscreen) {
  uiWindowSetFullscreen($!window, $fullscreen);
}

multi method fullscreen(Bool:D(Int) $fullscreen) {
  self.set-fullscreen($fullscreen);
}

multi method borderless() returns Bool {
  return uiWindowBorderless($!window).Bool;
}

method set-borderless(Bool:D(Int) $borderless) {
  uiWindowSetBorderless($!window, $borderless);
}

multi method borderless(Bool:D(Int) $borderless) {
  self.set-borderless($borderless);
}

multi method margined() returns Bool {
  return uiWindowMargined($!window).Bool;
}

method set-margined(Bool:D(Int) $margined) {
  uiWindowSetMargined($!window, $margined);
}

multi method margined(Bool:D(Int) $margined) {
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

C<new(Str:D $title, Int $width = 640, Int $height = 480, Bool(Int) $has-menubar = 1)>

Creates a window.

C<set-content(Libui::Control:D $control)>

Sets the child widget of the Window.

C<title() returns Str>

Returns the title of the Window.

C<set-title(Str:D $title)> or C<title(Str:D $title)>

Sets the title of the window.

C<content-size(int32 $width, int32 $height)> or C<content-size($width is rw where Int ~~ *, $height is rw where Int ~~ *)>

Sets the value of $width and $height to the width and height of the Window.

C<set-content-size(UInt $width, UInt $height)>

Sets the width and height of the Window. Does nothing until the L<show()|https://github.com/Garland-g/perl6-libui/wiki/Control#safe-method> is run

C<width() returns UInt>

Returns the width of the Window. Returns 1 until L<show()|https://github.com/Garland-g/perl6-libui/wiki/Control#safe-methods> has been run.

C<height() returns UInt>

Returns the height of the Window. Returns 1 until L<show()|https://github.com/Garland-g/perl6-libui/wiki/Control#safe-methods> has been run.

C<fullscreen() returns Bool>

Returns the value of the fullscreen property.

C<set-fullscreen(Int $fullscreen)> or C<fullscreen(Int $fullscreen)>

Sets the value of the fullscreen property.

C<borderless() returns Bool>

Returns the value of the borderless property.

C<set-borderless(Bool:D(Int) $borderless)> or C<borderless(Bool:D(Int) $borderless)>

Sets the value of the borderless property.

C<margined() returns Bool>

Returns the value of the margined property.

C<set-margined(Bool:D(Int) $margined)> or C<margined(Bool:D(Int) $margined)>

Sets the value of the margined property.

C<closing() returns Supply>

Returns a L<Supply|https://docs.perl6.org/Supply>. An event is emitted whenever the Window is signaled to close.

C<size-changed returns Supply>

Returns a L<Supply|https://docs.perl6.org/Supply>. An event is emitted whenever the Window's height or width changes.

C<open() returns Str>

Opens a native file chooser for opening files. Returns a Str that is the path to the chosen file.

C<save() returns Str>

Opens a native file chooser for saving files. Returns a Str that is the path to the chosen file.

C<msg-box(Str $title, Str $description)>

Opens a message box.

C<msg-box-err(Str $title, Str $description)>

Opens an error message box.
=end Window
