use Libui::Raw;
use Libui::Control;

unit class Libui::Combobox does Libui::Control;

has uiCombobox $!combobox;
has $!changed-supply;

submethod BUILD() {
	$!combobox = uiNewCombobox();
}

method append(Str $text) {
	uiComboboxAppend($!combobox, $text);
}

method selected() returns int32 {
	return uiComboboxSelected($!combobox);
}

method set-selected(int32 $n) {
	uiComboboxSetSelected($!combobox, $n);
}

method changed() {
	$!changed-supply //= do {
		my $s = Supplier.new;
		uiComboboxOnSelected($!combobox, -> $, $ {
			$s.emit(self);
			CATCH { default { $_; } }
		},
		Str);
		return $s.Supply;
	}
}

method !WIDGET() {
	return $!combobox;
}
