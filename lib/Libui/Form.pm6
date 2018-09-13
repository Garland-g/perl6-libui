use Libui::Raw :form;
use Libui::Container;

unit class Libui::Form;
also does Libui::Container;

has uiForm $!form;

submethod BUILD() {
  $!form = uiNewForm();
}

method append(Str $label, Libui::Control $c, int32 $stretchy) {
  if $c.top-level() {
    note "cannot place {$c.WHAT} into a Libui::Container";
  } else {
    uiFormAppend($!form, $label, $c.Control, $stretchy);
  }
}

method set-content(Str $label, Libui::Control $c, Int $stretchy) {
  self.append($label, $c, $stretchy);
}

method delete-item(int32 $index) {
  uiFormDelete($!form, $index);
}

multi method padded() returns int32 {
  return uiFormPadded($!form);
}

method set-padded(int32 $padded) {
  uiFormSetPadded($!form, $padded);
}

multi method padded(Int $padded) {
  self.set-padded($padded);
}

method !WIDGET() {
  return $!form;
}

=begin Form
=head2 Libui::Form

A box that holds several widgets. Both Vertical and Horizontal are available.

=head3 Methods

C<new()>

Create a Box.

C<append(Str $label, Libui::Control $control, int32 $stretchy)> or C<set-content(Str $label, Libui::Control $control, int32 $stretchy)>

Appends a widget to the Box. Stretchy determines whether the widget should stretch to fill the available space or not.

C<delete-item(int32 $index)>

Deletes the widget at index $index.

C<padded() returns int32>

Returns the value of the padded property.

C<set-padded(int32:D $padded)> or C<padded(Int $padded)>

Sets the value of the padded property.
=end Form
