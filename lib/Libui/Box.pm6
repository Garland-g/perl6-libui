use v6;
use Libui::Raw :box;
use Libui::Container;

role Libui::Box {
  also does Libui::Container;

  has uiBox $!box;

  method append-list(@control, @stretchy = (0,)) {
    for @control.kv -> $i, $control {
      if $control.top-level {
        note "cannot place {$control.WHAT} into a Libui::Container";
      } else {
        if $i < @stretchy.elems {
          uiBoxAppend(self!WIDGET, $control.Control, @stretchy[$i]);
        }  else {
          uiBoxAppend(self!WIDGET, $control.Control, @stretchy[*-1]);
        }
      }
    }
  }

  method append(Libui::Control $control, int32 $stretchy) {
    if $control.top-level() {
      note "cannot place {$control.WHAT} into a Libui::Box";
    } else {
      uiBoxAppend($!box, $control.Control, $stretchy);
    }
  }

  method delete-item(int32:D $index) {
    uiBoxDelete($!box, $index);
  }

  method set-content(Libui::Control $control, int32:D :$stretchy) {
    self.append($control, $stretchy);
  }

  multi method padded() returns int32 {
    return uiBoxPadded($!box);
  }

  method set-padded(int32:D $padded) {
    uiBoxSetPadded($!box, $padded);
  }

  multi method padded(Int $padded) {
    self.set-padded($padded);
  }

  method !WIDGET() {
    return $!box;
  }
}

class Libui::HBox is export {
  also does Libui::Box;

  submethod BUILD() {
    $!box = uiNewHorizontalBox();
  }
}

class Libui::VBox is export {
  also does Libui::Box;

  submethod BUILD() {
    $!box = uiNewVerticalBox();
  }
}

=begin Box
=head2 Libui::HBox, Libui::VBox

A box that holds several widgets. Both Vertical and Horizontal are available.

=head3 Methods

C<new()>

Create a Box.

C<append(Libui::Control $control, int32 $stretchy)> or C<set-content(Libui::Control $control, int32 $stretchy)>

Appends a widget to the Box. Stretchy determines whether the widget should stretch to fill the available space or not.

C<delete-item(int32:D $index)>

Deletes the widget at index $index.

C<padded() returns int32>

Returns the value of the padded property.

C<set-padded(int32:D $padded)> or C<padded(Int $padded)>

Sets the value of the padded property.
=end Box
