use Libui::Raw :spinbox;
use Libui::Control;

unit class Libui::Spinbox does Libui::Control;

has uiSpinbox $!spinbox;
has $!value-changed;

submethod BUILD(int32 :$min, int32 :$max) {
  $!spinbox = uiNewSpinbox($min, $max);
}

multi method new(Int $min, Int $max) {
  self.bless(:$min, :$max);
}

multi method value() returns int32 {
  uiSpinboxValue($!spinbox);
}

method set-value(int32 $value) {
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

C<value() returns int32>

Returns the value of the Spinbox.

C<set-value(int32 $value)> or C<value(Int $value)>

Sets the value of the Spinbox.

C<changed() returns Supply>

Returns a Supply. An event is emitted whenever the value is changed.
=end Spinbox
