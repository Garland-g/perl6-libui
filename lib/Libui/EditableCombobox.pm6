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
