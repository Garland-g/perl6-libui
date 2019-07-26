use Libui::Raw :lib;
use Libui::Control;

use NativeCall;

unit class Libui::Spinbox does Libui::Control;

class uiSpinbox is repr('CStruct') is export(:raw) {
  also does autocast;
  has Pointer $.uiSpinboxValue;
  has Pointer $.uiSpinboxSetValue;
  has Pointer $.uiSpinboxOnChanged;
  has Pointer $.uiNewSpinbox;
}

sub uiSpinboxValue(uiSpinbox $s)
  returns int32
  is native(LIB)
  is export(:raw)
  { * }


sub uiSpinboxSetValue(uiSpinbox $s, int32 $value)
  is native(LIB)
  is export(:raw)
  { * }


sub uiSpinboxOnChanged(uiSpinbox $s, &f (uiSpinbox, Pointer), Pointer $data)
  is native(LIB)
  is export(:raw)
  { * }


sub uiNewSpinbox(int64 $min, int64 $max)
  returns uiSpinbox
  is native(LIB)
  is export(:raw)
  { * }

has uiSpinbox $!spinbox;
has $!value-changed;

submethod BUILD(Int :$min, Int :$max) {
  $!spinbox = uiNewSpinbox($min, $max);
}

multi method new(Int $min, Int $max) {
  self.bless(:$min, :$max);
}

multi method value() returns Int {
  uiSpinboxValue($!spinbox);
}

method set-value(Int $value) {
  uiSpinboxSetValue($!spinbox, $value);
}

multi method value(Int $value) {
  self.set-value($value);
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
=begin Spinbox
=head2 Libui::Spinbox

A slider to select a number inside a given range.

=head3 Methods

C<new(Int $min, Int $max)>

Create a new Spinbox.

C<value() returns Int>

Returns the value of the Spinbox.

C<set-value(Int $value)> or C<value(Int $value)>

Sets the value of the Spinbox.

C<changed() returns Supply>

Returns a Supply. An event is emitted whenever the value is changed.
=end Spinbox
