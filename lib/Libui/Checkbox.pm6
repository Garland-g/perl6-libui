use Libui::Raw :checkbox;
use Libui::Control;

unit class Libui::Checkbox does Libui::Control;

has uiCheckbox $!checkbox;
has $!toggled-supply;

submethod BUILD(Str :$text) {
  $!checkbox = uiNewCheckbox($text);
}

multi method new(Str $text) {
  self.bless(:$text);
}

multi method text() returns Str {
  return uiCheckboxText($!checkbox);
}

multi method text(Str $text) {
  uiCheckboxSetText($!checkbox, $text);
}

method set-text(Str $text) {
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

multi method checked() returns int32 {
  uiCheckboxChecked($!checkbox);
}

multi method checked(Int $checked) {
  self.set-checked($checked);
}

method set-checked(int32 $checked) {
  uiCheckboxSetChecked($!checkbox, $checked);
}

method !WIDGET() {
  return $!checkbox;
}

=begin Checkbox
=head2 Libui::Checkbox

A standard checkbox.

=head3 Methods

C<new(Str $text)>

Creates a new Checkbox.

C<text() returns Str>

Returns the text of the Checkbox.

C<set-text(Str $text)> or C<text(Str $text)>

Sets the text of the Checkbox.

C<toggled() returns Supply>

Returns a L<Supply|https://docs.perl6.org/type/Supply>. An event is emitted whenever the Checkbox is toggled.

C<checked() returns int32>

Returns 0 if not checked, and returns 1 if checked.

C<set-checked(int32 $checked)> or C<checked(Int $checked)>

Sets the state of the checkbox. 0 means not checked, and 1 means checked.

=end Checkbox
