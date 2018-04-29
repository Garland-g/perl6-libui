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

unit module Libui is export;

sub Init($options = uiInitOptions.new) is export {
	my Str $err = uiInit($options);
	if $err {
		die $err;
	}
}

=begin pod

=head1 Libui

=head2 Perl6 binding to L<libui|https://github.com/andlabs/libui>

=head3 Cross-platform: Windows, Mac, Linux

This library provides an object-oriented interface to libui.

=head3 Basic Use:

=begin code
Init();
my Libui::App $app .= new("test");
$app.root.closing.tap({$app.exit});
$app.run();
=end code

=head4 Install from CPAN with:

C<zef install Libui>

=head2 Examples:
=head3 Controlgallery Tab: Basic Controls
=head4 Linux
[!controlgallery](./examples/controlgallery-linux.png)

=for Windows
[!controlgallery](./examples/controlgallery-windows.png)

=for Macos
[!controlgallery](./examples/controlgallery-macos.png)

=end pod
