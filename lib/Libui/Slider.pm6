use Libui::Raw;
use Libui::Control;

unit class Libui::Slider does Libui::Control;

has uiSlider $!slider;
has $!value-changed;

submethod BUILD(int32 :$min, int32 :$max) {
	$!slider = uiNewSlider($min, $max);
}

multi method new(Int $min, Int $max) {
	self.bless(:$min, :$max);
}

method value() returns int32 {
	uiSliderValue($!slider);
}

method set-value(int32 $value) {
	uiSliderSetValue($!slider, $value);
}

method changed() returns Supply {
	$!value-changed //= do {
		my $s = Supplier.new;
		uiSliderOnChanged($!slider, -> $, $ {
			$s.emit(self);
			CATCH { default { note $_; } }
		},
		Str);
		return $s.Supply;
	}
}

method !WIDGET() {
	return $!slider;
}
