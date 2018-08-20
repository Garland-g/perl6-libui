use Libui::Raw :init, :time;
use Libui::App;
use Libui::AttributedString;
use Libui::Button;
use Libui::Box;
use Libui::Checkbox;
use Libui::ColorButton;
use Libui::Combobox;
use Libui::EditableCombobox;
use Libui::Entry;
use Libui::FontButton;
use Libui::Form;
use Libui::Grid;
use Libui::Group;
use Libui::Label;
use Libui::Menu;
use Libui::MultilineEntry;
use Libui::Picker;
use Libui::ProgressBar;
use Libui::RadioButton;
use Libui::Separator;
use Libui::Slider;
use Libui::Spinbox;
use Libui::Tab;
use Libui::Window;

module Libui is export {
  our sub Init($options = uiInitOptions.new) {
    my Str $err = uiInit($options);
    if $err {
      die $err;
    }
  }
}


=begin pod

=head1 Libui

=head2 Perl6 binding to L<andlabs/libui|https://github.com/andlabs/libui>

andlabs/libui is currently alpha software. This binding works with the current release, 0.0.4.
It does not have full functionality, and is subject to change as andlabs/libui changes underneath it.
The raw bindings accessible in Libui::Raw should be feature-complete, but only some widgets have an object-oriented implementation.

=head3 Cross-platform: Windows, Mac, Linux

This library provides an object-oriented interface to libui.
Shared libraries ui.dll, libui.dylib, and libui.so are provided in resources.

=head3 Basic Use:

=begin code
use Libui;

Libui::Init;
my Libui::App $app .= new("test");

#This allows the window to be closed
#when the titlebar's close button is clicked
$app.window.closing.tap({$app.exit});

$app.run();
=end code

=head3 Widgets Provided:
=begin table
 Widget | Description
 =====================
 Button   | A simple button with a label and a callback
 Checkbox | A checkbox with a label and a callback
 Combobox | A simple combobox with a callback
 ColorButton | A button for selecting a color
 EditableCombobox | A combobox that can be edited
 Entry | Text input, can be disabled
 FontButton | A button for selecting a font (Incomplete: Cannot set programmatically)
 Form | A container that takes labels for its contents
 Grid | A container that aligns widgets for window design
 Group | A container that provides a title for a set of items
 Label | Displays a single line of text
 Menu | Creates a single column of an application menu
 MultilineEntry | An entry that allows multiple lines
 Time and Date Choosers | Allows choosing of a date and/or time
 ProgressBar | Displays a progress bar
 RadioButton | A set of radio buttons with a callback
 Separator | A simple vertical or horizontal separator
 Slider | A draggable slider for choosing a value in a range
 Spinbox | A numerical input with a minimum and maximum range
 Tab | A set named tabs for placing items in
 Window | Contains all the other widgets, cannot be embedded in a container
 VBox, HBox | A vertical or horizontal box for grouping items
=end table

=head4 Install from CPAN with:

C<zef install Libui>

=head2 Examples:

=head3 Controlgallery Tab: Basic Controls
=head4 Linux

L<./examples/controlgallery-linux.png>

=head4 Windows

L<./examples/controlgallery-windows.png>

=head4 Macos

L<./examples/controlgallery-macos.png>

=head3 License

L<Artistic License 2.0|./LICENSE>

=head3 Author

Travis Gibson

=end pod
