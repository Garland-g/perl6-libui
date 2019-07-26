use v6;
use Libui::Raw :lib;
use Libui::Control;
use Libui::Container;

use NativeCall;

class uiBox is repr('CStruct') is export(:box) {
  also does autocast;
  has Pointer $.uiBoxAppend;
  has Pointer $.uiBoxDelete;
  has Pointer $.uiBoxPadded;
  has Pointer $.uiBoxSetPadded;
  has Pointer $.uiNewHorizontalBox;
  has Pointer $.uiNewVerticalBox;
}

sub uiBoxAppend(uiBox $b, uiControl $child, int32 $stretchy)
  is native(LIB)
  is export(:box)
  { * }


sub uiBoxDelete(uiBox $b, ulong $index)
  is native(LIB)
  is export(:box)
  { * }


sub uiBoxPadded(uiBox $b)
  returns int32
  is native(LIB)
  is export(:box)
  { * }


sub uiBoxSetPadded(uiBox $b, int32 $padded)
  is native(LIB)
  is export(:box)
  { * }


sub uiNewHorizontalBox()
  returns uiBox
  is native(LIB)
  is export(:box)
  { * }


sub uiNewVerticalBox()
  returns uiBox
  is native(LIB)
  is export(:box)
  { * }

role Libui::Box {
  also does Libui::Container;

  has uiBox $!box;
  has UInt $!items = 0;

  method append(Libui::Control:D $control, Bool:D(Int) $stretchy) {
    if $control.top-level() {
      note "cannot place {$control.WHAT} into a Libui::Box";
    } else {
      uiBoxAppend($!box, $control.Control, $stretchy);
      $!items += 1;
    }
  }

  method delete-item(UInt:D $index) {
    if $!items > $index {
      uiBoxDelete($!box, $index);
      $!items -= 1;
    } else {
      die "No item at index $index";
    }
  }

  method set-content(Libui::Control:D $control, Bool:D(Int) :$stretchy) {
    self.append($control, $stretchy);
  }

  multi method padded() returns Bool {
    return uiBoxPadded($!box).Bool;
  }

  method set-padded(Bool:D(Int) $padded) {
    uiBoxSetPadded($!box, $padded);
  }

  multi method padded(Bool:D(Int) $padded) {
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

C<append(Libui::Control:D $control, Bool:D(Int) $stretchy)> or C<set-content(Libui::Control:D $control, Bool:D(Int) $stretchy)>

Appends a widget to the Box. Stretchy determines whether the widget should stretch to fill the available space or not.

C<delete-item(UInt:D $index)>

Deletes the widget at index $index.

C<padded() returns Bool>

Returns the value of the padded property.

C<set-padded(Bool:D(Int) $padded)> or C<padded(Bool:D(Int) $padded)>

Sets the value of the padded property.
=end Box
