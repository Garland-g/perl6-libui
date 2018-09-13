use Libui::Raw :color;
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

=begin ColorButton
=head2 Libui::ColorButton

A button for selecting a color. Stored as an RGBA quadruple where each number is a num64 in the range 0 to 1.0.

=head3 Methods

C<new()>

Creates a ColorButton

C<color(num64 $r is rw, num64 $g is rw, num64 $b is rw, num64 $a is rw)>

Places the R, G, B, and A values into each variable.

C<set-color(num64 $r, num64 $g, num64 $b, num64 $a)>

Sets the R, G, B, and A values of the ColorButton.

C<changed() returns Supply>

Returns a L<Supply|https://docs.perl6.org/type/Supply>. An event is emitted whenever the color is changed.
=end ColorButton
