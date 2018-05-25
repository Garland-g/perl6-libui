use Libui::Raw :radiobutton;
use Libui::Control;

unit class Libui::RadioButton does Libui::Control;

has uiRadioButtons $!radio-buttons;
has $!selected-supply;

submethod BUILD() {
	$!radio-buttons = uiNewRadioButtons();
}

method append(Str $text) {
	uiRadioButtonsAppend($!radio-buttons, $text);
}

multi method selected() returns int32 {
	uiRadioButtonsSelected($!radio-buttons);
}

method set-selected(int32 $n) {
	uiRadioButtonsSetSelected($!radio-buttons, $n);
}

multi method selected(Int $n) {
	self.set-selected($n);
}

method changed() {
	$!selected-supply //= do {
		my $s = Supplier.new;
		uiRadioButtonsOnSelected($!radio-buttons, -> $, $ {
			$s.emit(self);
			CATCH { default { note $_; } }
		},
		Str);
		return $s.Supply;
	}
}

method !WIDGET() {
	return $!radio-buttons;
}
