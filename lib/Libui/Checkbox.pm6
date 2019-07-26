use Libui::Raw :lib;
use Libui::Control;

use NativeCall;

unit class Libui::Checkbox does Libui::Control;

class uiCheckbox is repr('CStruct') is export(:raw) {
  also does autocast;
  has Pointer $.uiCheckboxText;
  has Pointer $.uiCheckboxSetText;
  has Pointer $.uiCheckboxOnToggled;
  has Pointer $.uiCheckboxChecked;
  has Pointer $.uiCheckboxSetChecked;
  has Pointer $uiNewCheckbox;
}

sub uiCheckboxText(uiCheckbox $c)
  returns Str
  is native(LIB)
  is export(:raw)
  { * }


sub uiCheckboxSetText(uiCheckbox $c, Str $text)
  is native(LIB)
  is export(:raw)
  { * }


sub uiCheckboxOnToggled(uiCheckbox $c, &f (uiCheckbox, Pointer), Pointer $data)
  is native(LIB)
  is export(:raw)
  { * }


sub uiCheckboxChecked(uiCheckbox $c)
  returns int32
  is native(LIB)
  is export(:raw)
  { * }


sub uiCheckboxSetChecked(uiCheckbox $c, int32 $checked)
  is native(LIB)
  is export(:raw)
  { * }


sub uiNewCheckbox(Str $text)
  returns uiCheckbox
  is native(LIB)
  is export(:raw)
  { * }



has uiCheckbox $!checkbox;
has $!toggled-supply;

submethod BUILD(Str:D :$text) {
  $!checkbox = uiNewCheckbox($text);
}

multi method new(Str $text) {
  self.bless(:$text);
}

multi method text() returns Str {
  return uiCheckboxText($!checkbox);
}

multi method text(Str:D $text) {
  uiCheckboxSetText($!checkbox, $text);
}

method set-text(Str:D $text) {
  uiCheckboxSetText($!checkbox, $text);
}

method toggled() returns Supply {
  $!toggled-supply //= do {
    my $s = Supplier.new;
    uiCheckboxOnToggled($!checkbox, -> $, $, {
      $s.emit(self);
      CATCH { default { note $_; } }
      },
    Str);
    return $s.Supply;
  }
}

multi method checked() returns Bool {
  uiCheckboxChecked($!checkbox).Bool;
}

multi method checked(Bool:D(Int) $checked) {
  self.set-checked($checked);
}

method set-checked(Bool:D(Int) $checked) {
  uiCheckboxSetChecked($!checkbox, $checked);
}

method !WIDGET() {
  return $!checkbox;
}

=begin Checkbox
=head2 Libui::Checkbox

A standard checkbox.

=head3 Methods

C<new(Str:D $text)>

Creates a new Checkbox.

C<text() returns Str>

Returns the text of the Checkbox.

C<set-text(Str:D $text)> or C<text(Str:D $text)>

Sets the text of the Checkbox.

C<toggled() returns Supply>

Returns a L<Supply|https://docs.perl6.org/type/Supply>. An event is emitted whenever the Checkbox is toggled.

C<checked() returns Bool>

Returns True if checked.

C<set-checked(Bool:D(Int) $checked)> or C<checked(Bool:D(Int) $checked)>

Sets the checked state of the checkbox.

=end Checkbox
