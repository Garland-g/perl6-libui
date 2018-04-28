use Libui::Raw;
use Libui::Control;

unit class Libui::Spinbox does Libui::Control;

has uiSpinbox $!spinbox;
has $!value-changed;

submethod BUILD(:$min, :$max) {
	$!spinbox = uiNewSpinbox($min, $max);
}

multi method new(int32 $min, int32 $max) {
	self.bless(:$min, :$max);
}

method value() returns int32 {
	uiSpinboxValue($!spinbox);
}

method set-value(int32 $value) {
	uiSpinboxSetValue($!spinbox, $value);
}

method changed() returns Supply {
	$!value-changed //= do {
		my $s = Supplier.new;
		uiSpinboxOnChanged($!spinbox, -> $, $ {
			$s.emit(self);
			CATCH { default { note $_; } }
		},
		Str);
		return $s.Supply;
	}
}

method !WIDGET() {
	return $!spinbox;
}
