use Libui::Raw :lib;
use Libui::Main :quit;
use Libui::Control;
use NativeCall;

class uiMenuItem is repr('CStruct') is export(:raw) {
  has Str $.name;
  has int $.type;
  has Pointer $.onClicked;
  has Pointer $.onClickedData;
  has Pointer $.gtype;
  has Pointer $.disabled;
  has Pointer $.checked;
  has Pointer $.windows;
  has Pointer $.uiMenuItemEnable;
  has Pointer $.uiMenuItemDisable;
  has Pointer $.uiMenuItemOnClicked;
  has Pointer $.uiMenuItemChecked;
  has Pointer $.uiMenuItemSetChecked;
}

sub uiMenuItemEnable(uiMenuItem $m)
  is native(LIB)
  is export(:raw)
  { * }


sub uiMenuItemDisable(uiMenuItem $m)
  is native(LIB)
  is export(:raw)
  { * }


sub uiMenuItemOnClicked(uiMenuItem $m, &f (uiMenuItem, Pointer), Pointer $data)
  is native(LIB)
  is export(:raw)
  { * }


sub uiMenuItemChecked(uiMenuItem $m)
  returns int32
  is native(LIB)
  is export(:raw)
  { * }


sub uiMenuItemSetChecked(uiMenuItem $m, int32 $checked)
  is native(LIB)
  is export(:raw)
  { * }





class Libui::MenuItem does Libui::Control {

  has uiMenuItem $!item;
  has $!clicked-supply;

#uiMenuItems are returned by the uiMenu methods
#therefore
#Libui::MenuItems are returned by Libui::Menu methods
  method new(uiMenuItem $item) {
    self.bless(item => $item);
  }

  submethod BUILD(uiMenuItem :$item) {
    $!item = $item;
  }

  method enable() {
    uiMenuItemEnable($!item);
  }

  method disable() {
    uiMenuItemDisable($!item);
  }

  method clicked() returns Supply {
    $!clicked-supply //= do {
      my $s = Supplier.new;
      uiMenuItemOnClicked($!item, -> $, $ {
        $s.emit(self);
        CATCH { default { note $_; } }
      },
      Str);
      $s.Supply;
    }
  }

  multi method checked() returns Bool {
    uiMenuItemChecked($!item).Bool;
  }

  method set-checked(Bool:D(Int) $checked) {
    uiMenuItemSetChecked($!item, $checked);
  }

  multi method checked(Bool:D(Int) $checked) {
    self.set-checked($checked);
  }

  method !WIDGET() {
    return $!item;
  }
}

class Libui::QuitItem is Libui::MenuItem {
  has uiMenuItem $!item;
  has $!clicked-supply;

  method clicked() returns Supply {
    $!clicked-supply //= do {
      #my Pointer[int32] $exit .= new;
      my $s = Supplier.new;
      uiOnShouldQuit(-> $ {
        $s.emit(self);
        CATCH { default { note $_; } }
        0;
      },
      Str);
      $s.Supply;
    }
  }
}

=begin MenuItem
=head2 Libui::MenuItem

An item in a L<Menu|https://github.com/Garland-g/perl6-libui/wiki/Menu>. They can only be created by Menu methods.

=head3 Methods

C<enable()>

Enables the MenuItem, allowing it to be clicked.

C<disable()>

Disables the MenuItem, preventing it from being clicked.

C<clicked() returns Supply>

Returns a L<Supply|https://docs.perl6.org/type/Supply>. An event is emitted whenever the MenuItem is clicked.

C<checked() returns Bool>

Returns True if the MenuItem is checked.

C<set-checked(Bool:D(Int) $checked)> or C<checked(Bool:D(Int) $checked)>

Sets the MenuItem's checked state.
=end MenuItem
