use Libui::Raw :lib;

use NativeCall;

class uiControl is repr('CStruct') is export(:MANDATORY) {
  has uint32                      $.Signature; # Typedef<uint32_t>->«unsigned int» Signature
  has uint32                    $.OSSignature; # Typedef<uint32_t>->«unsigned int» OSSignature
  has uint32                      $.TypeSignature; # Typedef<uint32_t>->«unsigned int» TypeSignature
  has Pointer                       $.Destroy; # F:void ( )* Destroy
  has Pointer                       $.Handle; # F:Typedef<uintptr_t>->«long unsigned int» ( )* Handle
  has Pointer                       $.Parent; # F:uiControl* ( )* Parent
  has Pointer                       $.SetParent; # F:void ( )* SetParent
  has Pointer                       $.Toplevel; # F:int ( )* Toplevel
  has Pointer                       $.Visible; # F:int ( )* Visible
  has Pointer                       $.Show; # F:void ( )* Show
  has Pointer                       $.Hide; # F:void ( )* Hide
  has Pointer                       $.Enabled; # F:int ( )* Enabled
  has Pointer                       $.Enable; # F:void ( )* Enable
  has Pointer                       $.Disable; # F:void ( )* Disable
}

role autocast is export(:autocast){
  also is uiControl;
  method uiControl() {
    return nativecast(uiControl, self);
  }
}

sub uicontrol($control) is export(:uicontrol) {
  return nativecast(uiControl, $control);
}

sub uiControlDestroy(uiControl)
  is native(LIB)
  is export(:raw)
  { * }


sub uiControlHandle(uiControl)
  returns uint32
  is native(LIB)
  is export(:raw)
  { * }


sub uiControlParent(uiControl)
  returns uiControl
  is native(LIB)
  is export(:raw)
  { * }


sub uiControlSetParent(uiControl, uiControl)
  is native(LIB)
  is export(:raw)
  { * }


sub uiControlToplevel(uiControl)
  returns int32
  is native(LIB)
  is export(:raw)
  { * }


sub uiControlVisible(uiControl)
  returns int32
  is native(LIB)
  is export(:raw)
  { * }


sub uiControlShow(uiControl)
  is native(LIB)
  is export(:raw)
  { * }


sub uiControlHide(uiControl)
  is native(LIB)
  is export(:raw)
  { * }


sub uiControlEnabled(uiControl)
  returns int32
  is native(LIB)
  is export(:raw)
  { * }


sub uiControlEnable(uiControl)
  is native(LIB)
  is export(:raw)
  { * }


sub uiControlDisable(uiControl)
  is native(LIB)
  is export(:raw)
  { * }



sub uiAllocControl(size_t $n, uint32 $OSsig, uint32 $typesig , Str $typenamestr)
  returns uiControl
  is native(LIB)
  is export(:raw)
  { * }


sub uiFreeControl(uiControl)
  is native(LIB)
  is export(:raw)
  { * }



sub uiControlVerifySetParent(uiControl, uiControl)
  is native(LIB)
  is export(:raw)
  { * }


sub uiControlEnabledToUser(uiControl)
  returns int32
  is native(LIB)
  is export(:raw)
  { * }



sub uiUserBugCannotSetParentOnToplevel(Str $type)
  is native(LIB)
  is export(:raw)
  { * }



role Libui::Control {

  method !WIDGET() { ... }

  method Control( --> uiControl) {
    return uicontrol(self!WIDGET());
  }

#TODO Add this to all widgets in a DESTROY method so that they garbage collect themselves properly on the C side.
  method destroy() {
    uiControlDestroy(self.Control);
  }

  multi method parent() returns uiControl {
    return uiControlParent(self.Control);
  }

  method set-parent(Libui::Control $control)  {
    uiControlSetParent(self.Control, $control.Control);
  }

  multi method parent(Libui::Control $control) {
    self.set-parent($control.Control);
  }

  method top-level() returns Bool {
    return uiControlToplevel(self.Control).Bool;
  }

  method visible() returns Bool {
    return uiControlVisible(self.Control).Bool;
  }

  method show() {
    uiControlShow(self.Control);
  }

  method hide() {
    uiControlHide(self.Control);
  }

  method enabled() returns Bool {
    return uiControlEnabled(self.Control).Bool;
  }

  method enable() {
    uiControlEnable(self.Control);
  }

  method disable() {
    uiControlDisable(self.Control);
  }

}

=begin Control
=head2 Libui::Control

The role that all widgets inherit from. Contains several utility methods common to all controls.

The methods C<show()>, C<hide()>, C<visible()>, C<enable()>, C<disable()>, C<enabled()>, and C<top-level()> are safe for general use. The rest expose underlying C representations, with all the danger that brings.

=head3 Safe Methods

C<visible() returns Bool>

Returns the value of the visible property of the Control.

C<show()>

Makes the Control visible.

C<hide()>

Makes the Control invisible.

C<enabled() returns Bool>

Returns the value of the enabled property of the Control.

C<enable()>

Enables the Control.

C<disable()>

Disables the Control.

C<top-level() returns Bool>

Returns the value of the top-level property of the Control. Only Windows are top-level.

=head3 Dangerous Methods

C<Control() returns uiControl>

Returns the underlying CStruct cast as a uiControl.

C<destroy()>

Destroys the C representation of the Control

C<parent()>

Returns the C representation of the parent of the Control.

C<set-parent(Libui::Control $control)> or C<parent(Libui::Control $control)>

Sets the parent of the Control.

=end Control
