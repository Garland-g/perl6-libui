use Libui::Raw :radiobutton;
use Libui::Control;
use Libui::Types;

unit class Libui::RadioButton does Libui::Control;

has uiRadioButtons $!radio-buttons;
has $!selected-supply;

submethod BUILD() {
  $!radio-buttons = uiNewRadioButtons();
}

method append(Str $text) {
  uiRadioButtonsAppend($!radio-buttons, $text);
}

multi method selected() returns SSIZE_T {
  uiRadioButtonsSelected($!radio-buttons);
}

method set-selected(SSIZE_T $n) {
  uiRadioButtonsSetSelected($!radio-buttons, $n);
}

multi method selected(Int $n) {
  self.set-selected($n);
}

method changed() {
  $!selected-supply //= do {
    my $s = Supplier.new;
    uiRadioButtonsOnSelected($!radio-buttons, -> $, $ {
      $s.emit(self);
      CATCH { default { note $_; } }
    },
    Str);
    return $s.Supply;
  }
}

method !WIDGET() {
  return $!radio-buttons;
}

=begin RadioButtons
=head2 Libui::RadioButton

A set of buttons where only one option can be chosen.

=head3 Methods

C<new()>

Creates a new set of RadioButtons.

C<append(Str $text)>

Adds another RadioButton to the set.

C<selected() returns SSIZE_T>

Returns the index of the currently selected RadioButton.

C<set-selected(SSIZE_T $n)> or C<selected(Int $n)>

Sets the selected RadioButton

C<changed() returns Supply>

Returns a L<Supply|https://docs.perl6.org/type/Supply>. An event is emitted whenever the selected RadioButton changes.

See L<SSIZE_T|https://github.com/Garland-g/perl6-Libui/wiki/Types>.

=end RadioButtons
