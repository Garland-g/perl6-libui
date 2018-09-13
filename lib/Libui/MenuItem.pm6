use Libui::Raw :menu, :quit;
use Libui::Control;
use NativeCall;

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

  multi method checked() returns int32 {
    uiMenuItemChecked($!item);
  }

  method set-checked(int32 $checked) {
    uiMenuItemSetChecked($!item, $checked);
  }

  multi method checked(Int $checked) {
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

C<checked() returns int32>

Returns 1 if the MenuItem is checked and 0 if it is unchecked.

C<set-checked(int32 $checked)> or C<checked(Int $checked)>

Sets the MenuItem's checked state.
=end MenuItem
