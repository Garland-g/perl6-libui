use Libui::Raw;
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

method selected() returns int32 {
	uiRadioButtonsSelected($!radio-buttons);
}

method get-selected(int32 $n) {
	uiRadioButtonsSetSelected($!radio-buttons, $n);
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
