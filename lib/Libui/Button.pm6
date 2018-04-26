use Libui::Raw;
use Libui::Control;

unit class Libui::Button does Libui::Control;

has uiButton $!button;
has $!clicked-supply;

submethod BUILD(Str :$label!) {
	$!button = uiNewButton($label);
}

multi method new(Str $label) {
	self.bless(:$label);
}

method text() returns Str {
	return uiButtonText($!button);
}

method set-text(Str $label) {
	uiButtonSetText($!button, $label);
}

method clicked() returns Supply {
	$!clicked-supply //= do {
		my $s = Supplier.new;
		uiButtonOnClicked($!button, -> $, $ {
			$s.emit(self);
			CATCH { default { note $_; } }
			},
		Str);
		return $s.Supply;
	}
}

method !WIDGET() {
	return $!button;
}
