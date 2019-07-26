use Libui::Raw :lib;
use Libui::Control;

use NativeCall;

unit class Libui::Label
  does Libui::Control;

class uiLabel is repr('CStruct') is export(:raw) {
  also does autocast;
  #has Pointer $.c;
  #has Pointer $.widget;
  #has Pointer $.misc;
  #has Pointer $.label;
  has Pointer $.uiLabelText;
  has Pointer $.uiLabelSetText;
  has Pointer $.uiNewLabel;
}

sub uiLabelText(uiLabel $l)
  returns Str
  is native(LIB)
  is export(:raw)
  { * }


sub uiLabelSetText(uiLabel $l, Str $text)
  is native(LIB)
  is export(:raw)
  { * }


sub uiNewLabel(Str $text)
  returns uiLabel
  is native(LIB)
  is export(:raw)
  { * }



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
