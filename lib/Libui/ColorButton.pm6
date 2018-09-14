use Libui::Raw :color;
use Libui::Control;

use Color;

subset RGBA of Num where 0 <= * <= 1;

unit class Libui::ColorButton does Libui::Control;

has uiColorButton $!button;
has $!changed-supply;

submethod BUILD() {
  $!button = uiNewColorButton();
}

multi method raw-color(num64 $r is rw, num64 $g is rw, num64 $b is rw, num64 $a is rw) {
  uiColorButtonColor($!button, $r, $g, $b, $a);
}

multi method raw-color($nr is rw where Num ~~ *, $ng is rw where Num ~~ *, $nb is rw where Num ~~ *, $na is rw where Num ~~ *) {
  #Fails with "Killed" without this workaround
  my num64 ($r, $g, $b, $a);
  self.raw-color($r, $g, $b, $a);
  ($nr, $ng, $nb, $na) = ($r, $g, $b, $a);
}

method raw-set-color(RGBA $r, RGBA $g, RGBA $b, RGBA $a) {
  uiColorButtonSetColor($!button, $r, $g, $b, $a);
}

multi method color() returns Color {
  my Num ($r, $g, $b, $a);
  self.raw-color($r, $g, $b, $a);
  return Color.new(rgbad => [$r, $g, $b, $a]);
}

multi method color(Color $color) {
  self.set-color($color);
}

multi method set-color(*@args, *%hash) {
  self.set-color(Color.new(|@args, |%hash));
}

multi method set-color(Color $color) {
  self.raw-set-color(|($color.rgbad>>.Num));
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

A button for selecting a color. Stored as an RGBA quadruple where each number is a num64 in the range 0 to 1.0. The L<Color module|https://github.com/zoffixznet/perl6-Color> is used to accept a wider variety of input.

=head3 Methods

C<new()>

Creates a ColorButton

C<color() returns Color>

Returns the color in the ColorButton as a Color.

C<set-color(Color $color)> or C<color(Color $color)>

Sets the color using the Color.

C<set-color(*@args, *%hash)>

Sets the color by constructing a Color and using it.

C<raw-color(num64 $r is rw, num64 $g is rw, num64 $b is rw, num64 $a is rw)>

Places the R, G, B, and A values into each variable. Only accepts num64.

C<raw-color($nr is rw where Num ~~ *, $ng is rw where Num ~~ *, $nb is rw where Num ~~ *, $na is rw where Num ~~ *)>

Places the R, G, B, and A values into each variable. Accepts any type that accepts a Num.

C<raw-set-color(num64 $r, num64 $g, num64 $b, num64 $a)>

Sets the R, G, B, and A values of the ColorButton.

C<changed() returns Supply>

Returns a L<Supply|https://docs.perl6.org/type/Supply>. An event is emitted whenever the color is changed.
=end ColorButton
