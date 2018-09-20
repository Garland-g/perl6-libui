use Libui::Raw :label;
use Libui::Control;

unit class Libui::Label
  does Libui::Control;

has uiLabel $!label;

submethod BUILD(Str:D :$text) {
  $!label = uiNewLabel($text);
}

multi method new(Str $text){
  self.bless(:$text);
}

multi method text() returns Str {
  return uiLabelText($!label);
}

method set-text(Str:D $text) {
  uiLabelSetText($!label, $text);
}

multi method text(Str:D $text) {
  self.set-text($text);
}

method !WIDGET() {
  return $!label;
}

=begin Label
=head2 Libui::Label

A label for displaying text

=head3 Methods

C<new(Str:D $text)>

Creates a Label

C<text() returns Str>

Returns the text content of the Label.

C<set-text(Str:D $text)> or C<text(Str:D $text)>

Sets the text content of the Label.
=end Label
