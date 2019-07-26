use Libui::Raw :lib;
use Libui::Control;
use Libui::Types;

use NativeCall;

unit class Libui::RadioButton does Libui::Control;

class uiRadioButtons is repr('CStruct') is export(:raw) {
  also does autocast;
  has Pointer $.uiRadioButtonsAppend;
  has Pointer $.uiRadioButtonsSelected;
  has Pointer $.uiRadioButtonsSetSelected;
  has Pointer $.uiRadioButtonsOnSelected;
  has Pointer $.uiNewRadioButtons;
}

sub uiRadioButtonsAppend(uiRadioButtons $r, Str $text)
  is native(LIB)
  is export(:raw)
  { * }


sub uiNewRadioButtons()
  returns uiRadioButtons
  is native(LIB)
  is export(:raw)
  { * }


sub uiRadioButtonsSelected(uiRadioButtons  $r)
  returns int32
  is native(LIB)
  is export(:raw)
  { * }

sub uiRadioButtonsSetSelected(uiRadioButtons $r, int32 $n)
  returns int32
  is native(LIB)
  is export(:raw)
  { * }

sub uiRadioButtonsOnSelected(uiRadioButtons  $r, &f (uiRadioButtons, Pointer), Pointer $data)
  is native(LIB)
  is export(:raw)
  { * }


has uiRadioButtons $!radio-buttons;
has $!selected-supply;

submethod BUILD() {
  $!radio-buttons = uiNewRadioButtons();
}

method append(Str:D $text) {
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

C<append(Str:D $text)>

Adds another RadioButton to the set.

C<selected() returns SSIZE_T>

Returns the index of the currently selected RadioButton.

C<set-selected(SSIZE_T $n)> or C<selected(Int $n)>

Sets the selected RadioButton

C<changed() returns Supply>

Returns a L<Supply|https://docs.perl6.org/type/Supply>. An event is emitted whenever the selected RadioButton changes.

See L<SSIZE_T|https://github.com/Garland-g/perl6-Libui/wiki/Types#ssize_t>.

=end RadioButtons
