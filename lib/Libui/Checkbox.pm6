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
