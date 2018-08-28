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
