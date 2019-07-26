use Libui::Raw :lib;
use Libui::Control;
use Libui::Types;

use NativeCall;

unit class Libui::Combobox does Libui::Control;

class uiCombobox is repr('CStruct') is export(:combobox) {
  also does autocast;
  has Pointer $.uiComboboxAppend;
  has Pointer $.uiComboboxSelected;
  has Pointer $.uiComboboxSetSelected;
  has Pointer $.uiComboBoxOnSelected;
  has Pointer $.uiNewCombobox;
}

sub uiComboboxAppend(uiCombobox $c, Str $text)
  is native(LIB)
  is export(:combobox)
  { * }


sub uiComboboxSelected(uiCombobox $c)
  returns int64
  is native(LIB)
  is export(:combobox)
  { * }


sub uiComboboxSetSelected(uiCombobox $c, int64 $n)
  is native(LIB)
  is export(:combobox)
  { * }


sub uiComboboxOnSelected(uiCombobox $c, &f (uiCombobox, Pointer), Pointer $data)
  is native(LIB)
  is export(:combobox)
  { * }


sub uiNewCombobox()
  returns uiCombobox
  is native(LIB)
  is export(:combobox)
  { * }



has uiCombobox $!combobox;
has $!changed-supply;

submethod BUILD() {
  $!combobox = uiNewCombobox();
}

method append(Str:D $text) {
  uiComboboxAppend($!combobox, $text);
}

multi method selected() returns SSIZE_T {
  return uiComboboxSelected($!combobox);
}

method set-selected(SSIZE_T $n) {
  uiComboboxSetSelected($!combobox, $n);
}

multi method selected(SSIZE_T $n) {
  self.set-selected($n);
}

method changed() {
  $!changed-supply //= do {
    my $s = Supplier.new;
    uiComboboxOnSelected($!combobox, -> $, $ {
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

=begin Combobox
=head2 Libui::Combobox

A standard combobox.

=head3 Methods

C<new()>

Creates a new Libui::Combobox.

C<append(Str:D $text)>

Adds another row to the Combobox containing $text.

C<selected() returns SSIZE_T>

Returns the number of the row of selected text.

C<selected(SSIZE_T $n)> or C<set-selected(SSIZE_T $n)>

Sets the selected row to the given value.

C<changed() returns Supply>

Returns a L<Supply|https://docs.perl6.org/type/Supply>. An event is emitted whenever the selection is changed.

See L<SSIZE_T|https://github.com/Garland-g/perl6-Libui/wiki/Types#ssize_t>.

=end Combobox
