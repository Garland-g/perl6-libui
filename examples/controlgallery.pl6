use v6;

use lib 'lib';
use Libui;


sub makeBasicControlsPage() returns Libui::Control {
	my $vbox = Libui::VBox.new;
	my $hbox = Libui::HBox.new;
	my $group = Libui::Group.new(title => "Entries");
	my $entryform = Libui::Form.new;
	
	$vbox.set-padded(1);
	$hbox.set-padded(1);
	$vbox.append($hbox, 0);
	$hbox.append(Libui::Button.new(label => "Button"), 0);
	$hbox.append(Libui::Checkbox.new(text => "Checkbox"), 0); 
	$vbox.append(Libui::Label.new(text => "This is a label. Right now, labels can only span one line."), 0);
	$vbox.append(Libui::HSeparator.new(), 0);
	$group.set-margined(1);
	$vbox.append($group, 1);
	$entryform.set-padded(1);
	$group.set-child($entryform);
	$entryform.append("Entry", Libui::Entry.new(), 0);
	$entryform.append("Password Entry", Libui::PasswordEntry.new(), 0);
	$entryform.append("Search Entry", Libui::SearchEntry.new(), 0);
	$entryform.append("Multiline Entry", Libui::MultilineEntry.new(), 1);
	$entryform.append("Multiline Entry No Wrap", Libui::NonWrappingMultilineEntry.new, 1);

	return $vbox;
}

sub makeNumbersPage() {
	my $hbox = Libui::HBox.new;
	my $vbox = Libui::VBox.new;
	my $group = Libui::Group.new(title => "Numbers");
	$hbox.set-padded(1);
	$hbox.append($group, 1);
	$group.set-margined(1);
	$group.set-child($vbox);
	$vbox.set-padded(1);
	my $spinbox = Libui::Spinbox.new(min => 0, max => 100);
	my $slider = Libui::Slider.new(min => 0, max => 100);
	my $pbar = Libui::ProgressBar.new;
	$spinbox.changed.tap( -> $spin { $slider.set-value($spin.value);});
	$slider.changed.tap( -> $slide { 
		$spinbox.set-value($slide.value);
		$pbar.set-value($slide.value);
	});
	$vbox.append($spinbox, 0);
	$vbox.append($slider, 0);
	$vbox.append($pbar, 0);

	my $ip = Libui::ProgressBar.new;
	$ip.set-value(-1);
	$vbox.append($ip, 0);

	$group = Libui::Group.new(title => "Lists");
	$group.set-margined(1);
	$hbox.append($group, 1);

	$vbox = Libui::VBox.new;
	$vbox.set-padded(1);
	$group.set-child($vbox);

	my $cbox = Libui::Combobox.new;
	$cbox.append("Combobox Item 1");
	$cbox.append("Combobox Item 2");
	$cbox.append("Combobox Item 3");
	$vbox.append($cbox, 0);
	
	my $ecbox = Libui::EditableCombobox.new;
	$ecbox.append("EditableCombobox Item 1");
	$ecbox.append("EditableCombobox Item 2");
	$ecbox.append("EditableCombobox Item 3");
	$vbox.append($ecbox, 0);

	my $rb = Libui::RadioButton.new;
	$rb.append("Radio Button 1");
	$rb.append("Radio Button 2");
	$rb.append("Radio Button 3");
	$vbox.append($rb, 0);

	return $hbox;
}

sub makeDataChoosersPage(Libui::Window $window) {
	my $hbox = Libui::HBox.new;
	$hbox.set-padded(1);
	my $vbox = Libui::VBox.new;
	$vbox.set-padded(1);

	$hbox.append($vbox, 0);

	$vbox.append(Libui::DatePicker.new, 0);
	$vbox.append(Libui::TimePicker.new, 0);
	$vbox.append(Libui::DateTimePicker.new, 0);

	$vbox.append(Libui::FontButton.new, 0);
	$vbox.append(Libui::ColorButton.new, 0);
	$hbox.append(Libui::VSeparator.new, 0);

	$vbox = Libui::VBox.new();
	$vbox.set-padded(1);
	$hbox.append($vbox,1);

	my $grid = Libui::Grid.new();
	$grid.set-padded(1);
	$vbox.append($grid, 0);

	my $button = Libui::Button.new(label => "Open File");
	my $entry = Libui::Entry.new;

	$entry.set-read-only(1);
	$button.clicked.tap( {
		my Str $filename;

		$filename = $window.open();
		if $filename {
			$entry.set-text($filename); 
			
		} else {
			$entry.set-text("(cancelled)");
		}
	});
	
	$grid.append($button, 0, 0, 1, 1, 0, 0, 0, 0);
	$grid.append($entry, 1, 0, 1, 1, 1, 0, 0, 0);

	my $button2 = Libui::Button.new(label =>"Save File");
	my $entry2 = Libui::Entry.new;
	$entry2.set-read-only(1);
	$button2.clicked.tap( {
		my Str $filename;

		$filename = $window.open();
		if $filename {
			$entry2.set-text($filename);
		} else {
			$entry2.set-text("(cancelled)");
		}
	});
	$grid.append($button2, 0, 1, 1, 1, 0, 0, 0, 0);
	$grid.append($entry2, 1, 1, 1, 1, 1, 0, 0, 0);

	my $msggrid = Libui::Grid.new;
	$msggrid.set-padded(1);
	$grid.append($msggrid, 0, 2, 2, 1, 0, 2, 0, 1);

	my $msgbox-button = Libui::Button.new(label => "Message Box");
	$msgbox-button.clicked.tap({ 
		$window.msg-box("This is a normal message box."
									, "More detailed information can be shown here.")
	});
	$msggrid.append($msgbox-button, 0, 0, 1, 1, 0, 0, 0, 0);

	my $msgbox-err-button = Libui::Button.new(label => "Error Box");
	$msgbox-err-button.clicked.tap({ 
		$window.msg-box-err("This message box describes an error."
									, "More detailed information can be shown here.")
	});
	$msggrid.append($msgbox-err-button, 1, 0, 1, 1, 0, 0, 0, 0);

	return $hbox;
}

Libui-Init();

my $app = Libui::App.new(title => "libui Control Gallery", width => 640, height => 480, has-menubar => 0);
$app.root.closing.tap({ $app.exit });
my $window = $app.root;
my $tab = Libui::Tab.new();
$app.set-content($tab);
$window.set-margined(1);
$tab.append("Basic Controls", makeBasicControlsPage());
$tab.set-margined(0, 1);
$tab.append("Numbers and Lists", makeNumbersPage());
$tab.set-margined(1, 1);
$tab.append("Data Choosers", makeDataChoosersPage($window));
$tab.set-margined(2, 1);
$app.run();
