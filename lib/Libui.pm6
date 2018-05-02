use Libui::App;
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
use Libui::Raw;
use Libui::Separator;
use Libui::Slider;
use Libui::Spinbox;
use Libui::Tab;
use Libui::Window;

class Libui is export {

	# Initializes the library
	sub Libui-Init($options = uiInitOptions.new) is export {
		my Str $err = uiInit($options);
		if $err {
			die $err;
		}
	}
}


=begin pod

=head1 Libui

=head2 Perl6 binding to L<andlabs/libui|https://github.com/andlabs/libui>

=head3 Cross-platform: Windows, Mac, Linux

This library provides an object-oriented interface to libui.

=head3 Basic Use:

=begin code
use Libui;

Libui-Init();
my Libui::App $app .= new("test");
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
 FontButton | A button for selecting a font (incomplete, cannot get data out)
 Form | A container that takes labels for its contents
 Grid | A container that aligns widgets for window design
 Group | A container that provides a title for a set of items
 Label | Displays a single line of text
 Menu | Creates a single column of an application menu
 MultilineEntry | An entry that allows multiple lines
 Time and Date Choosers | Allows choosing of a date and/or time (incomplete, cannot get data out)
 ProgressBar | Displays a progress bar (incomplete, can only set progress)
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

!L<|./examples/controlgallery-linux.png>

=head4 Windows

!L<|./examples/controlgallery-windows.png>

=head4 Macos

!L<|./examples/controlgallery-macos.png>

=head3 License

L<Artistic License 2.0|./LICENSE>

=end pod
