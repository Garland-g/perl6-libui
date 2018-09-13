use Libui::Raw :label;
use Libui::Control;

unit class Libui::Label
  does Libui::Control;

has uiLabel $!label;

submethod BUILD(Str :$text) {
  $!label = uiNewLabel($text);
}

multi method new(Str $text){
  self.bless(:$text);
}

multi method text() returns Str {
  return uiLabelText($!label);
}

method set-text(Str $text) {
  uiLabelSetText($!label, $text);
}

multi method text(Str $text) {
  self.set-text($text);
}

method !WIDGET() {
  return $!label;
}

=begin Label
=head2 Libui::Label

A label for displaying text

=head3Methods

C<new(Str $text)>

Creates a Libui::Label

C<text() returns Str>

Returns the text content of the Label.

C<set-text(Str $text)> or C<text(Str $text)>

Sets the text content of the Label.
=end Label
