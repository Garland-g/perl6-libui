use v6;
use Libui::Raw;
use Libui::Window;
use Libui::Menu;
unit class Libui::App;

has Libui::Window $!window;

multi submethod BUILD(Str :$title!
               ,UInt :$width where { $width > 0 } = 640
               ,UInt  :$height where { $height > 0 } = 480
               ,Bool(Int) :$has-menubar = 1
               ) {
  $!window = Libui::Window.new(title => $title, width => $width, height => $height, has-menubar => $has-menubar);
}

multi submethod BUILD(Libui::Window:D :$window) {
  $!window = $window;
}

multi method new( Str $title
                , UInt $width  = 640
                , UInt $height = 480
                , Bool(Int) $has-menubar = 1
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

method set-content(Libui::Control:D $control) {
  $!window.set-content($control);
}

=begin App
=head2 Libui::App

App facilitates the creation of a GUI application with Libui, providing methods to C<run()> and C<exit()> an application.

=head3 Methods

C<new(Str $title, UInt $width = 640, UInt $height = 480, Bool(Int) $has-menubar = 1)> or C<new(Libui::Window:D $window)>

Creates a new App.

C<root() returns Libui::Window > or C<window() returns Libui::Window>

Returns the Window.

C<show()>

Calls L<show()|https://github.com/Garland-g/perl6-libui/wiki/Control#safe-methods> on the window.

C<run()>

Runs the App. The method blocks the main thread. Other threads can be run, but Libui methods that modify objects cannot be run from a separate thread. L<Channels|https://docs.perl6.org/type/Channel> and L<Supplies|https://docs.perl6.org/type/Supply> can be used to send data that the main thread responds to.

C<exit()>

Closes the App, but does not terminate the program.

C<set-content(Libui::Control:D $control)>

Sets the content of the Window.
=end App
