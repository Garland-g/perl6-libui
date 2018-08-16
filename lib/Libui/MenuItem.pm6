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
