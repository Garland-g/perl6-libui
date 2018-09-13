use Libui::Raw :combobox;
use Libui::Control;

unit class Libui::Combobox does Libui::Control;

has uiCombobox $!combobox;
has $!changed-supply;

submethod BUILD() {
  $!combobox = uiNewCombobox();
}

method append(Str $text) {
  uiComboboxAppend($!combobox, $text);
}

multi method selected() returns uint32 {
  return uiComboboxSelected($!combobox);
}

method set-selected(uint32 $n) {
  uiComboboxSetSelected($!combobox, $n);
}

multi method selected(UInt $n) {
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

C<append(Str $text)>

Adds another row to the Combobox containing $text.

C<selected() returns uint32>

Returns the number of the row of selected text.

C<selected(UInt $n)> or C<set-selected(uint32 $n)>

Sets the selected row to the given value.

C<changed() returns Supply>

Returns a L<Supply|https://docs.perl6.org/type/Supply>. An event is emitted whenever the selection is changed.

=end Combobox
