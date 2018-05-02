use Libui::Raw;
use Libui::Control;

unit class Libui::ColorButton does Libui::Control;

has uiColorButton $!button;
has $!changed-supply;

submethod BUILD() {
	$!button = uiNewColorButton();
}

multi method color(num64 $r is rw, num64 $g is rw, num64 $b is rw, num64 $a is rw) {
	uiColorButtonColor($!button, $r, $g, $b, $a);
}

method set-color(num64 $r, num64 $g, num64 $b, num64 $a) {
	uiColorButtonSetColor($!button, $r, $g, $b, $a);
}

method changed() {
	$!changed-supply //= do {
		my $s = Supplier.new;
		uiColorButtonOnChanged($!button, -> $, $ {
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
