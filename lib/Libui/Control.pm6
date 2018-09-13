use Libui::Raw :control, :uicontrol;

unit role Libui::Control;

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

method top-level() returns int32 {
  return uiControlToplevel(self.Control);
}

method visible() returns int32 {
  return uiControlVisible(self.Control);
}

method show() {
  uiControlShow(self.Control);
}

method hide() {
  uiControlHide(self.Control);
}

method enabled() returns int32 {
  return uiControlEnabled(self.Control);
}

method enable() {
  uiControlEnable(self.Control);
}

method disable() {
  uiControlDisable(self.Control);
}

=begin Control
=head2 Libui::Control

The role that all widgets inherit from. Contains several utility methods common to all controls.

The methods C<show()>, C<hide()>, C<visible()>, C<enable()>, C<disable()>, C<enabled()>, and C<top-level()> are safe for general use. The rest expose underlying C representations, with all the danger that brings.

=head3 Safe Methods

C<visible() returns int32>

Returns the value of the visible property of the Control.

C<show()>

Makes the Control visible.

C<hide()>

Makes the Control invisible.

C<enabled() returns int32>

Returns the value of the enabled property of the Control.

C<enable()>

Enables the Control.

C<disable()>

Disables the Control.

C<top-level() returns int32>

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
