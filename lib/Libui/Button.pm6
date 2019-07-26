use Libui::Raw :lib;
use Libui::Control;

use NativeCall;

unit class Libui::Button does Libui::Control;

class uiButton is repr('CStruct') is export(:raw) {
  also does autocast;
  has Pointer $.uiButtonText;
  has Pointer $.uiSetText;
  has Pointer $.uiButtononClicked;
  has Pointer $.onClicked;
  has Pointer $.onClickedData;
}

sub uiButtonText(uiButton $b)
  returns Str
  is native(LIB)
  is export(:raw)
  { * }


sub uiButtonSetText(uiButton $b, Str $text)
  is native(LIB)
  is export(:raw)
  { * }


sub uiButtonOnClicked(uiButton $b, &f (uiButton, Pointer), Pointer $data)
  is native(LIB)
  is export(:raw)
  { * }


sub uiNewButton(Str $text)
  returns uiButton
  is native(LIB)
  is export(:raw)
  { * }



has uiButton $!button;
has $!clicked-supply;

submethod BUILD(Str:D :$label!) {
  $!button = uiNewButton($label);
}

multi method new(Str $label) {
  self.bless(:$label);
}

multi method text() returns Str {
  return uiButtonText($!button);
}

method set-text(Str:D $label) {
  uiButtonSetText($!button, $label);
}

multi method text(Str:D $label) {
  self.set-text($label);
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

=begin Button
=head2 Libui::Button

A button with a label.

=head3 Methods

C<new(Str:D :$label)>

Creates a new Libui::Button.

C<text() returns Str>

Returns the label.

C<text(Str:D $label)> or C<set-text(Str:D $label)>

Sets the label.

C<clicked() returns Supply>

Returns a L<Supply|https://docs.perl6.org/type/Supply>. An event is emitted whenever the button is pressed.
=end Button
