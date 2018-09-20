use Libui::Raw :form;
use Libui::Container;

unit class Libui::Form;
also does Libui::Container;

has uiForm $!form;
has UInt $!items = 0;

submethod BUILD() {
  $!form = uiNewForm();
}

method append(Str:D $label, Libui::Control $c, Bool:D(Int) $stretchy) {
  if $c.top-level() {
    note "cannot place {$c.WHAT} into a Libui::Container";
  } else {
    uiFormAppend($!form, $label, $c.Control, $stretchy);
    $!items++;
  }
}

method set-content(Str:D $label, Libui::Control $c, Bool:D(Int) $stretchy) {
  self.append($label, $c, $stretchy);
}

method delete-item(UInt $index) {
  if $index < $!items {
    uiFormDelete($!form, $index);
    $!items--;
  } else {
    die "No item at index $index";
  }
}

multi method padded() returns Bool {
  return uiFormPadded($!form).Bool;
}

method set-padded(Bool:D(Int) $padded) {
  uiFormSetPadded($!form, $padded);
}

multi method padded(Bool:D(Int) $padded) {
  self.set-padded($padded);
}

method !WIDGET() {
  return $!form;
}

=begin Form
=head2 Libui::Form

A container that assigns a label to each widget.

=head3 Methods

C<new()>

Create a Form.

C<append(Str:D $label, Libui::Control $control, Bool:D(Int) $stretchy)> or C<set-content(Str:D $label, Libui::Control $control, Bool:D(Int) $stretchy)>

Appends a widget to the Form. Stretchy determines whether the widget should stretch to fill the available space or not.

C<delete-item(UInt $index)>

Deletes the widget at index $index.

C<padded() returns Bool>

Returns the value of the padded property.

C<set-padded(Bool:D(Int) $padded)> or C<padded(Bool:D(Int) $padded)>

Sets the value of the padded property.
=end Form
