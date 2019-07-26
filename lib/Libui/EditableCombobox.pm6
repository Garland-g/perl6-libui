use Libui::Raw :lib;
use Libui::Control;

use NativeCall;

unit class Libui::EditableCombobox does Libui::Control;

class uiEditableCombobox is repr('CStruct') is export(:raw) {
  also does autocast;
  has Pointer $.uiEditableComboboxAppend;
  has Pointer $.uiEditableComboboxText;
  has Pointer $.uiEditableComboboxSetText;
  has Pointer $.uiEditableComboboxOnChanged;
  has Pointer $.uiNewEditableCombobox;
}

sub uiEditableComboboxAppend(uiEditableCombobox $c, Str $text)
  is native(LIB)
  is export(:raw)
  { * }


sub uiEditableComboboxText(uiEditableCombobox $c)
  returns Str
  is native(LIB)
  is export(:raw)
  { * }


sub uiEditableComboboxSetText(uiEditableCombobox $c, Str $text)
  is native(LIB)
  is export(:raw)
  { * }



sub uiEditableComboboxOnChanged(uiEditableCombobox $c, &f (uiEditableCombobox, Pointer), Pointer $data)
  is native(LIB)
  is export(:raw)
  { * }


sub uiNewEditableCombobox()
  returns uiEditableCombobox
  is native(LIB)
  is export(:raw)
  { * }



has uiEditableCombobox $!combobox;
has $!changed-supply;

submethod BUILD() {
  $!combobox = uiNewEditableCombobox();
}

method append(Str:D $text) {
  uiEditableComboboxAppend($!combobox, $text);
}

multi method text() returns Str {
  return uiEditableComboboxText($!combobox);
}

method set-text(Str:D $text) {
  uiEditableComboboxSetText($!combobox, $text);
}

multi method text(Str:D $text) {
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

C<append(Str:D $text)>

Adds another row containing $text to the Combobox.

C<text() returns Str>

Returns the currently selected text.

C<set-text(Str:D $text)> or C<text(Str:D $text)>

Sets the text field of the currently selected item to $text.

C<changed() returns Supply>

Returns a L<Supply|https://docs.perl6.org/type/Supply>. An event is emitted whenever a new item is selected.
=end EditableCombobox
