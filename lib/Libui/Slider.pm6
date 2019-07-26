use Libui::Raw :lib;
use Libui::Control;

use NativeCall;

unit class Libui::Slider does Libui::Control;

class uiSlider is repr('CStruct') is export(:raw) {
  also does autocast;
#  has Pointer $.widget;
#  has Pointer $.range;
#  has Pointer $.scale;
  has Pointer $.uiSliderValue;
  has Pointer $.uiSliderSetValue;
#  has Pointer $.uiSliderOnChanged;
  has Pointer $.onChangedData;
  has Pointer $.uiNewSlider;
}

sub uiSliderValue(uiSlider $s)
  returns int32
  is native(LIB)
  is export(:raw)
  { * }


sub uiSliderSetValue(uiSlider $s, int64 $value)
  is native(LIB)
  is export(:raw)
  { * }


sub uiSliderOnChanged(uiSlider $s, &f (uiSlider, Pointer), Pointer $data)
  is native(LIB)
  is export(:raw)
  { * }


sub uiNewSlider(int64 $min, int64 $max)
  returns uiSlider
  is native(LIB)
  is export(:raw)
  { * }


has uiSlider $!slider;
has $!value-changed;

submethod BUILD(Int :$min, Int :$max) {
  $!slider = uiNewSlider($min, $max);
}

multi method new(Int $min, Int $max) {
  self.bless(:$min, :$max);
}

multi method value() returns Int {
  uiSliderValue($!slider);
}

method set-value(Int $value) {
  uiSliderSetValue($!slider, $value);
}

multi method value(Int $value) {
  self.set-value($value);
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

=begin Slider
=head2 Libui::Slider

A slider to select a number inside a given range.

=head3 Methods

C<new(Int $min, Int $max)>

Create a new Slider.

C<value() returns Int>

Returns the value of the Slider.

C<set-value(Int $value)> or C<value(Int $value)>

Sets the value of the Slider.

C<changed() returns Supply>

Returns a Supply. An event is emitted whenever the value is changed.

=end Slider
