use Libui::Raw :e-combobox;
use Libui::Control;

unit class Libui::EditableCombobox does Libui::Control;

has uiEditableCombobox $!combobox;
has $!changed-supply;

submethod BUILD() {
  $!combobox = uiNewEditableCombobox();
}

method append(Str $text) {
  uiEditableComboboxAppend($!combobox, $text);
}

multi method text() returns Str {
  return uiEditableComboboxText($!combobox);
}

method set-text(Str $text) {
  uiEditableComboboxSetText($!combobox, $text);
}

multi method text(Str $text) {
  self.set-text($text);
}

method changed() {
  $!changed-supply //= do {
    my $s = Supplier.new;
    uiEditableComboboxOnChanged($!combobox, -> $, $ {
      $s.emit(self);
      CATCH { default { $_; } }
    },
    Str);
    return $s.Supply;
  }
}

method !WIDGET() {
  return $!combobox;
}

=begin EditableCombobox
=head2 Libui::EditableCombobox

A combobox that can be edited by the end user.

=head3 Methods

C<new()>

Creates a new EditableCombobox.

C<append(Str $text)>

Adds another row containing $text to the Combobox.

C<text() returns Str>

Returns the currently selected text.

C<set-text(Str $text)> or C<text(Str $text)>

Sets the text field of the currently selected item to $text.

C<changed() returns Supply>

Returns a L<Supply|https://docs.perl6.org/type/Supply>. An event is emitted whenever a new item is selected.
=end EditableCombobox
