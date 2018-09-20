use Libui::Raw :combobox;
use Libui::Control;
use Libui::Types;

unit class Libui::Combobox does Libui::Control;

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
